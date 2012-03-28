require 'sinatra'
require 'sinatra/base'
require 'sinatra/reloader'

Dir["./lib/**/*.rb"].each { |helper| require helper }
Dir["./models/**/*.rb"].each { |model| require model }

set :root, File.dirname(__FILE__)

class EasyRetroApp < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    redirect '/index.html'
  end

  post '/board' do
    content_type :json

    redirect "/board/#{params['name']}", 303 if Board.find_by_name(params['name'])

    status 201
    Board.create(:name => params['name'], :post_its => []).to_json
  end

  get '/board/:name' do |name|
    content_type :json
    Board.find_by_name(name).to_json
  end

  post '/board/:name/post_it' do |name|
    board = Board.find_by_name(name)
    post_it = PostIt.new  :text => params['text'],
                          :top => params['top'],
                          :left => params['left'],
                          :group => params['group']

    board.post_its << post_it
    board.save

    content_type :json
    status 201
    post_it.to_json
  end

  get '/board/:name/post_it/:id' do |name, id|
    content_type :json
    status 200
    board = Board.find_by_name(name)
    board.post_its.find(id).to_json
  end

end
