require 'mongo_mapper'
require 'uri'

configure :production do
  uri = URI.parse(ENV['MONGOHQ_URL'])
  MongoMapper.connection = Mongo::Connection.from_uri(ENV['MONGOLAB_URI'])
  MongoMapper.database = uri.path.gsub(/^\//, '')
end

configure :development do
  MongoMapper.database = "easy_retro"
end
