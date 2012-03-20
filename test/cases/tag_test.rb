require 'helper'

class TagTest < IsMsfteTaggable::TestCase
  
  it 'invalidates name without kind' do
    IsMsfteTaggable::Tag.create! :name => "duplicate"
    IsMsfteTaggable::Tag.new(:name => "duplicate").wont_be :valid?
  end
  
  it 'allows duplicate names of different kinds' do
    IsMsfteTaggable::Tag.create! :name => "not dup", :kind => "something"
    IsMsfteTaggable::Tag.new(:name => "not dup").must_be :valid?
  end
  
  it 'will not be initailly valid' do
    IsMsfteTaggable::Tag.new.wont_be :valid?
  end
  
  it 'validates errors on name' do
    t = IsMsfteTaggable::Tag.new
    t.valid?
    t.errors[:name].must_be :present?
  end
  
  it 'WAT'  do
    IsMsfteTaggable::Tag.create!(:name => "iamawesome", :kind => "awesomestuff")
    IsMsfteTaggable::Tag.find_or_initialize_with_name_like_and_kind("iamawesome", "awesomestuff")
  end
  
  it 'WAT 2' do
    IsMsfteTaggable::Tag.create!(:name => "iamawesome", :kind => "stuff")
    IsMsfteTaggable::Tag.find_or_initialize_with_name_like_and_kind("iamawesome", "otherstuff").must_be :new_record?
  end
  
  it 'WAT 3' do
    tag = IsMsfteTaggable::Tag.create!(:kind => "language", :name => "French")
    IsMsfteTaggable::Tag.of_kind("language").first.must_equal tag
  end

end
