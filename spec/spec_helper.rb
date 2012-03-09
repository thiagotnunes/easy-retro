require File.join(File.dirname(__FILE__), '..', 'app')
require 'sinatra'
require 'rack/test'
require 'rspec'

include Rack::Test::Methods

class EasyRetroApp < Sinatra::Base
  set :environment, :test

end

def app
  EasyRetroApp
end
