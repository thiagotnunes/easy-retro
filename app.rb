require 'sinatra'
require 'sinatra/base'
require './lib/boards'

set :root, File.dirname(__FILE__)

class EasyRetroApp < Sinatra::Base

    before do
        @boards = BoardRepo.new
    end

    get '/' do
        redirect '/index.html'
    end

    post '/boards' do 
        @boards.insert(params) 
    end

    put '/boards' do
        @boards.insert(params) unless @boards.find_one(:name => params['name'])
    end

    get '/boards/:name' do |name|
        content_type :json
        @boards.get(name).to_json
    end

end
