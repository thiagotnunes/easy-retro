require 'mongo_mapper'

class Board
  include MongoMapper::Document

  key :name, String, :required => true, :unique => true

  many :post_its

  def eql?(other)
    self.class.eql?(other.class) &&
       name == other.name
  end
  alias :== :eql?

end                                                                 

