$:.push File.expand_path("../lib", __FILE__)
require 'is_msfte_taggable/version'

Gem::Specification.new do |s|
  s.name          = 'is_msfte_taggable'
  s.version       = IsMsfteTaggable::VERSION
  s.platform      = Gem::Platform::RUBY
  s.authors       = ['Brian Knox','Ken Collins']
  s.email         = ['gnutse@gmail.com','ken@metaskills.net']
  s.homepage      = 'http://github.com/Decisiv/is_msfte_taggable/'
  s.summary       = 'Tagging with full text search for MS SQL Server'
  s.description   = 'Extends ActiveRecord models to have tagging with full text search capability'
  s.files         = `git ls-files`.split("\n") - ["is_msfte_searchable.gemspec"]
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']
  s.rdoc_options  = ['--charset=UTF-8']
  s.add_runtime_dependency     'activerecord',                    '~> 3.2.0'
  s.add_runtime_dependency     'activerecord-sqlserver-adapter',  '~> 3.2.0'
  s.add_development_dependency 'rake',           '~> 0.9.2'
  s.add_development_dependency 'minitest',       '~> 2.8.1'
  s.add_development_dependency 'sqlite3',        '~> 1.3'
  s.add_development_dependency 'tiny_tds'
  s.add_development_dependency 'database_cleaner'
end
