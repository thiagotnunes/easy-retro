require 'bundler'
Bundler.require :test

task :default => :spec

desc "Run all tests"
task :spec => ["test:unit", "test:js"]

desc "Run server in development mode"
task :start => 'start:development'

namespace 'test' do
  desc "Run the unit tests"
  task :unit do
    sh 'RACK_ENV=test; bundle exec rspec spec/*_spec.rb --color --format progress'
  end

  desc "Run the javascript tests"
  task :js => 'js:ci'

  namespace 'js' do
    task :ci => ['jasmine:ci']

    desc "Run the javascript tests server"
    task :server => ['jasmine:server']
  end

end

namespace :start do
  [:production, :test, :development].each do |env|
    desc "Start server in #{env} mode"
    task env do
      debug_mode = env == :development ? '--debug' : ''
      system("thin -R config.ru #{debug_mode} -e #{env} start")
    end
  end
end

directory "./db/dev"

desc "Run the mongo db"
task :db => ["./db/dev"] do
    system("mongod --dbpath db/dev/")
end

namespace :jasmine do
  task :ci => [:require_jasmine] do
    Rake::Task['jasmine:ci'].invoke
  end
  task :server => [:require_jasmine] do
    Rake::Task['jasmine:server'].invoke
  end
end

task :require_jasmine do
  begin
    require 'jasmine'
    load 'jasmine/tasks/jasmine.rake'
    system("export DISPLAY=:99.0")
  rescue LoadError
    task :jasmine do
      abort "Jasmine is not available. In order to run jasmine, you must: (sudo) gem install jasmine"
    end
  end
end
