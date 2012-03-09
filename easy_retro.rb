require 'sinatra'
require 'sinatra/base'
require 'sinatra/reloader'

require File.join(File.dirname(__FILE__), 'lib', 'board_listener')
require File.join(File.dirname(__FILE__), 'models', 'board')

set :root, File.dirname(__FILE__)

class EasyRetroApp < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  before do
    @boards = Board.new(mongo['boards'])
  end

  get '/' do
    redirect '/index.html'
  end

  post '/boards' do 
    @boards.insert(params) 
  end

  put '/boards' do
    @boards.update(params)
  end

  get '/boards/:name' do |name|
    content_type :json
    @boards.get(name).to_json
  end

  get '/css/easy_retro.css' do
    scss :easy_retro
  end

end
