namespace :mongo do
  gem_root = Gem::Specification.find_by_name("mongrations").gem_dir
  @path = File.join(gem_root, "db", "mongrations")

  desc "Migrate the database through scripts in db/mongrations. Target specific version with VERSION=x."
  task :mongrate => :environment do
    MongoMapper::Migrator.migrate(@path, ENV["VERSION"] ? ENV["VERSION"].to_i : nil)
  end

  namespace :mongrate do
    desc  'Rollbacks the database one mongration and re migrate up. If you want to rollback more than one step, define STEP=x. Target specific version with VERSION=x.'
    task :redo => :environment do
      if ENV["VERSION"]
        Rake::Task["mongo:mongrate:down"].invoke
        Rake::Task["mongo:mongrate:up"].invoke
      else
        Rake::Task["mongo:mongrate:rollback"].invoke
        Rake::Task["mongo:mongrate"].invoke
      end
    end

    desc 'Runs the "up" for a given mongration VERSION.'
    task :up => :environment do
      version = ENV["VERSION"] ? ENV["VERSION"].to_i : nil
      raise "VERSION is required" unless version
      MongoMapper::Migrator.run(:up, @path, version)
    end

    desc 'Runs the "down" for a given mongration VERSION.'
    task :down => :environment do
      version = ENV["VERSION"] ? ENV["VERSION"].to_i : nil
      raise "VERSION is required" unless version
      MongoMapper::Migrator.run(:down, @path, version)
    end

    desc 'Rolls the schema back to the previous version. Specify the number of steps with STEP=n'
    task :rollback => :environment do
      step = ENV['STEP'] ? ENV['STEP'].to_i : 1
      MongoMapper::Migrator.rollback(@path, step)
    end

    desc 'Show the current version of the mongrations'
    task :version => :environment do
      puts MongoMapper::Migrator.current_version
    end    
  end
end
