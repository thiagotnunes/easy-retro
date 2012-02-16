require 'sinatra'
require 'mongo'
require 'json'

set :root, File.dirname(__FILE__)

class EasyRetroApp < Sinatra::Base

    before do
        @boards = mongo['boards']
    end

    get '/' do
        return redirect '/index.html'
    end

    post '/boards' do 
        @boards.insert(params)
    end

    get '/boards' do
        return @boards.find.each { |board| puts board }
    end

    get '/boards/:name' do |name|
        content_type :json
        return @boards.find_one(:name => name).to_json
    end

end
