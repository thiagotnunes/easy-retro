require 'mongo_mapper'

MongoMapper.connection = Mongo::Connection.from_uri(ENV['MONGOLAB_URI']) if ENV['MONGOLAB_URI']

configure :development do
  MongoMapper.database = "easy_retro"
end
