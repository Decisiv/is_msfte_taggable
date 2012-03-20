
class Post < ActiveRecord::Base
  is_msfte_taggable :tags, :languages, :unique
end

