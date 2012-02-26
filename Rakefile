require 'bundler'
Bundler.require :test

namespace 'test' do
  desc "Run the unit tests"
  task :unit do
    sh 'RACK_ENV=test; bundle exec rspec spec/*_spec.rb --color --format progress'
  end

  desc "Run the javascript tests"
  task :js => 'js:ci'

  namespace 'js' do
    task :default => :ci

    task :ci => ['jasmine:ci']

    desc "Run the javascript tests server"
    task :server => ['jasmine:server']
  end

end

#task :spec => ["test:unit", "test:acceptance", "test:js"]
task :spec => ["test:unit", "test:js"]
task :default => :spec

desc "Run the server"
task :start do
  system("thin -R config.ru start")
end

desc "Run the mongo db"
task :db do
    system("mongod --dbpath /tmp/db & > /dev/null")
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

