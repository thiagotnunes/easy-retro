require 'sinatra'
require 'mongo'
require 'json'

class EasyRetroApp < Sinatra::Base

    before do
        @boards = mongo['boards']
    end

    get '/' do
        return File.open("public/index.html")
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

    get '/*' do |file|
        return File.open('public/' + file)
    end

end
