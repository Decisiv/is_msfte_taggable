Gem::Specification.new do |s|
  s.name = "is_msfte_taggable"
  s.version = "0.0.4"
  s.date = "2009-09-10"
  s.summary = "Tagging with full text search for MS SQL Server"
  s.email = "gnutse@gmail.com"
  s.homepage = "http://github.com/decisiv/is_msfte_taggable/"
  s.description = "Extends ActiveRecord models to have tagging with full text search capability"
  s.has_rdoc = true
  s.authors = ["Ken Collins","Brian Knox"]
  s.files = [
    "init.rb",
    "README.rdoc",
    "CHANGELOG",
    "lib/is_msfte_taggable.rb",
    "lib/is_msfte_taggable/tagging.rb",
    "lib/is_msfte_taggable/tag.rb",
    "generators/is_msfte_taggable/is_msfte_taggable_generator.rb",
    "generators/is_msfte_taggable/USAGE",
    "generators/is_msfte_taggable/templates/autocomplete.js.erb",
    "generators/is_msfte_taggable/templates/migration.rb",
    "generators/is_msfte_taggable/templates/taggable_controller.rb",
    "generators/is_msfte_taggable/templates/taggable_helper.rb"
  ]
  s.test_files = [
    "test/is_msfte_taggable_test.rb",
    "test/tagging_test.rb",
    "test/tag_test.rb",
    "test/test_helper.rb"
  ]
  s.rdoc_options = ["--main", "README.rdoc"]
  s.extra_rdoc_files = ["README.rdoc","CHANGELOG"]
end
