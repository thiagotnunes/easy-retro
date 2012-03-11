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
    redirect "/board/#{params['name']}" if Board.find_by_name(params['name'])

    Board.create(:name => params['name'], :post_its => [])
  end

  put '/board' do
  end

  get '/board/:name' do |name|
    content_type :json
    Board.find_by_name(name).to_json
  end

end
