module IsMsfteTaggable
  
  class TagList < Array
    def to_s
      join(', ')
    end
  end

  module Base
    
    def is_msfte_taggable(*kinds)
      class_attribute :tag_kinds
      self.tag_kinds = kinds.map(&:to_s).map(&:singularize)
      self.tag_kinds << :tag if kinds.empty?
      include IsMsfteTaggable::TaggableMethods
    end
    
  end

  module TaggableMethods
    
    def self.included(klass)
      klass.class_eval do
        
        extend ClassMethods
        include InstanceMethods

        has_many   :taggings, :class_name => 'IsMsfteTaggable::Tagging', :as => :taggable
        has_many   :tags,     :through => :taggings
        after_save :save_tags
        
        tag_kinds.each do |k|
          define_method("#{k}_list")  { get_tag_list(k) }
          define_method("#{k}_list=") { |new_list| set_tag_list(k, new_list) }
          scope "with_#{k}_tags".to_sym, lambda { |tag_or_tags|
            if tag_or_tags.blank?
              {}
            else
              start_condition = "id IN (SELECT taggable_id FROM #{Tagging.table_name}, #{Tag.table_name}  
                WHERE #{Tagging.table_name}.taggable_type = '#{klass.name}' AND #{Tagging.table_name}.tag_id = #{Tag.table_name}.id AND
                CONTAINS (#{Tag.table_name}.name, '#{make_search_string(tag_or_tags, 'OR')}'))"
              { :conditions => start_condition }
            end
          }
        end

        scope "with_tags".to_sym, lambda { |tag_or_tags|
          if tag_or_tags.blank?
            {}
          else
            start_condition = "id IN (SELECT taggable_id FROM #{Tagging.table_name}, #{Tag.table_name}  
              WHERE #{Tagging.table_name}.taggable_type = '#{klass.name}' AND #{Tagging.table_name}.tag_id = #{Tag.table_name}.id AND
              CONTAINS (#{Tag.table_name}.name, '#{make_search_string(tag_or_tags,'OR')}'))"
            { :conditions => start_condition }
          end
        }
        
      end
    end
    
    module ClassMethods
      
      def make_search_string(search_string, boolean="OR")
        search_string.split(/ +/).map {|term| '"' + term + ' *"'}.join(" #{boolean} ")
      end
      
    end

    module InstanceMethods
      
      def set_tag_list(kind, list)
        list.gsub!(/ *, */,',') unless list.is_a?(Array)
        tag_list = TagList.new(list.is_a?(Array) ? list : list.split(','))
        instance_variable_set(tag_list_name_for_kind(kind), tag_list)
      end

      def get_tag_list(kind)
        set_tag_list(kind, tags.of_kind(kind).map(&:name)) if tag_list_instance_variable(kind).nil?
        tag_list_instance_variable(kind)
      end


      protected
      
      def tag_list_name_for_kind(kind)
        "@#{kind}_list"
      end
      
      def tag_list_instance_variable(kind)
        instance_variable_get(tag_list_name_for_kind(kind))
      end

      def save_tags
        tag_kinds.each do |tag_kind|
          delete_unused_tags(tag_kind)
          add_new_tags(tag_kind)
        end
        taggings.each(&:save)
      end

      def delete_unused_tags(tag_kind)
        tags.of_kind(tag_kind).each { |t| tags.delete(t) unless get_tag_list(tag_kind).include?(t.name) }
      end

      def add_new_tags(tag_kind)
        tag_names = tags.of_kind(tag_kind).map(&:name)
        get_tag_list(tag_kind).each do |tag_name| 
          tags << Tag.find_or_initialize_with_name_like_and_kind(tag_name, tag_kind) unless tag_names.include?(tag_name)
        end
      end
        
    end
    
  end
end

ActiveSupport.on_load(:active_record) { extend IsMsfteTaggable::Base }

