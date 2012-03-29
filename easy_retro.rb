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

  before do
    content_type :json
  end

  get '/' do
    redirect '/index.html'
  end

  post '/board' do
    status 201

    redirect "/board/#{params['name']}", 303 if Board.find_by_name(params['name'])

    Board.create(:name => params['name'], :post_its => []).to_json
  end

  get '/board/:name' do |name|
    Board.find_by_name(name).to_json
  end

  post '/board/:name/post_it' do |name|
    status 201

    board = Board.find_by_name(name)
    post_it = board.add_using params
    post_it.to_json
  end

  get '/board/:name/post_it/:id' do |name, id|
    status 200

    board = Board.find_by_name(name)
    post_it = board.find id

    return not_found if post_it == nil

    post_it.to_json
  end

  put '/board/:name/post_it/:id' do |name, id|
    status 200

    board = Board.find_by_name(name)
    post_it = board.find id

    return not_found if post_it == nil

    post_it.update_attributes!(params[:post_it])
    post_it.to_json
  end

  delete '/board/:name/post_it/:id' do |name, id|
    status 200

    board = Board.find_by_name(name)
    post_it = board.find id

    return not_found if post_it == nil

    board.pull(:post_its => {:_id => post_it.id})
    post_it.to_json
  end

end
