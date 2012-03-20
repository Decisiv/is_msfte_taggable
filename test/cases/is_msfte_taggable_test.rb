require 'helper'

class IsMsfteTaggableTest < IsMsfteTaggable::TestCase
  
  it 'Tag' do
    Post.new.tags.build.must_be_instance_of IsMsfteTaggable::Tag
  end
  
  it 'Tagging' do
    Post.new.taggings.build.must_be_instance_of IsMsfteTaggable::Tagging
  end
  
  it 'has a tag list' do
    p = Post.new :tag_list => "something cool, something else cool"
    p.tag_list.must_equal ["something cool", "something else cool"]
  end
  
  it 'can reset tag lists' do
    p = Post.new :tag_list => "something cool, something else cool"
    p.save!
    p.tag_list = "something cool, something new"
    p.save!
    p.tags.reload
    p.instance_variable_set("@tag_list", nil)
    p.tag_list.must_equal ["something cool", "something new"]
  end
  
  it 'will split lists' do
    p = Post.new :language_list => "english, french"
    p.save!
    p.tags.reload
    p.instance_variable_set("@language_list", nil)
    p.language_list.must_equal ["english", "french"]
  end
  
  it 'splits list on assignment' do
    p = Post.new :language_list => "english, french"
    p.language_list.must_equal ["english", "french"]
  end
  
  it 'will yield orig string comma seped list when using to_s' do
    p = Post.new :language_list => "english, french"
    p.language_list.to_s.must_equal "english, french"
  end
  
  it 'should clean up strings with arbitrary spaces around commas' do
    p = Post.new
    p.tag_list = "spaces,should,  not,matter"
    p.save!
    p.tags.reload
    p.tag_list.must_equal ["spaces","should","not","matter"]
  end

  it 'WAT' do
    p = Post.new :language_list => "english, french"
    p.save!
    p.tags.length.must_equal 2
  end

end
