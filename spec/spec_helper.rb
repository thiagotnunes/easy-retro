require File.join(File.dirname(__FILE__), '..', 'easy_retro')
require 'sinatra'
require 'rack/test'
require 'rspec'

include Rack::Test::Methods

class EasyRetroApp < Sinatra::Base
  set :environment, :test
  MongoMapper.database = "easy_retro_test"
end

def app
  EasyRetroApp
end

RSpec.configure do |config|
  config.before do
    MongoMapper.database.collections.select {|c| c.name !~ /system/ }.each(&:remove)
  end
end
