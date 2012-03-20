require 'helper'

class TaggingTest < IsMsfteTaggable::TestCase
  
  it 'must be a tag class' do
    t = IsMsfteTaggable::Tagging.new :tag => IsMsfteTaggable::Tag.new(:name => 'some_tag')
    t.tag.must_be_instance_of IsMsfteTaggable::Tag
  end
  
end
