module IsMsfteTaggable
  class Tagging < ActiveRecord::Base
    
    self.table_name = 'taggings'
    
    belongs_to :tag, :class_name => 'IsMsfteTaggable::Tag', :foreign_key => 'tag_id'
    
  end
end
