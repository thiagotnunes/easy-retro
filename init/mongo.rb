require 'mongo_mapper'

configure :production do
  require 'uri'

  uri = URI.parse(ENV['MONGOLAB_URI'])
  MongoMapper.connection = Mongo::Connection.from_uri(ENV['MONGOLAB_URI'])
  MongoMapper.database = uri.path.gsub(/^\//, '')
end

configure :development do
  MongoMapper.database = "easy_retro"
end
