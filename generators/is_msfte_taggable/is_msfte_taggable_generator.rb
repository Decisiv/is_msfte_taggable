class IsMsfteTaggableGenerator < Rails::Generator::NamedBase

  def manifest
    record do |m|

      m.migration_template 'migration.rb', "db/migrate", {
        :assigns => { :migration_name => 'CreateTaggables' },
        :migration_file_name => 'create_taggables'
      }

      if options[:with_tasks]
        m.file 'blah', :collison => :skip
      end
    end
  end

  private

  def banner
    "\nUsage: script/generate is_taggable . [options]\n\n"
  end

  def add_options!(opt)
    opt.separator ''
    opt.separator 'Options:'
    opt.on("--with-tasks",
      "Generate tasks for MSFTE catalog setup") { |v| options[:with_tasks] = v }
  end

end
