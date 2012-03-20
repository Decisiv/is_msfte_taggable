module IsMsfteTaggable
  class Tag < ActiveRecord::Base
    
    self.table_name = 'tags'
    
    has_many :taggings, :class_name => 'IsMsfteTaggable::Tagging', :foreign_key => 'tag_id'

    validates_presence_of :name
    validates_uniqueness_of :name, :scope => :kind

    scope :with_name_like_and_kind, lambda { |name, kind| { :conditions => ["name like ? AND kind = ?", name, kind] } }
    scope :of_kind,                 lambda { |kind| { :conditions => {:kind => kind} } }
    scope :unique_by_name_for_kind, lambda { |kind| { :conditions => {:kind => kind}, :group => 'id,name,kind,created_at,updated_at' } }
    
    class << self
      
      def find_or_initialize_with_name_like_and_kind(name, kind)
        with_name_like_and_kind(name, kind).first || new(:name => name, :kind => kind)
      end
      
      def unique_tag_list_by_kind(kind)
        unique_by_name_for_kind('available_service').map(&:name)
      end
      
    end
    
  
  end
end
