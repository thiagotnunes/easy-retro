require 'sinatra'
require 'sinatra/base'
require './lib/boards'

set :root, File.dirname(__FILE__)

class EasyRetroApp < Sinatra::Base

    before do
        @boards = Boards.new(mongo['boards'])
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
