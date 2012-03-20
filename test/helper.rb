require 'rubygems'
require 'bundler'
require "bundler/setup"
Bundler.require
require 'is_msfte_taggable'
require 'active_record/base'
require 'database_cleaner'
require 'minitest/autorun'
require 'logger'


ActiveRecord::Base.logger = nil # Logger.new(File.join(File.dirname(__FILE__),'debug.log'))
ActiveRecord::Base.establish_connection :adapter => 'sqlserver', 
  :host => ENV['IS_MSFTE_TAGGABLE_HOST'],
  :username => ENV['IS_MSFTE_TAGGABLE_USER'],
  :password => ENV['IS_MSFTE_TAGGABLE_PASS'],
  :database => 'is_msfte_taggable_test'


require 'lib/schema'
require 'lib/models'

module IsMsfteTaggable
  class TestCase < MiniTest::Spec
    
    before { DatabaseCleaner.start }
    after  { DatabaseCleaner.clean }
    
    
  end
end


