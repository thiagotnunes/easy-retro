require 'sinatra'
require 'mongo'
require 'json'

set :root, File.dirname(__FILE__)

class EasyRetroApp < Sinatra::Base

    before do
        @boards = mongo['boards']
    end

    get '/' do
        redirect '/index.html'
    end

    post '/boards' do 
        @boards.insert(params) unless @boards.find_one(:name => params['name'])
    end

    get '/boards' do
        @boards.find.each { |board| puts board }
    end

    get '/boards/:name' do |name|
        content_type :json
        @boards.find_one(:name => name).to_json
    end

end
