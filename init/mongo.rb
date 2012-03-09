require 'sinatra/mongo'

set :mongo, ENV['MONGOLAB_URI'] || "mongo://localhost:27017/easy_retro"
