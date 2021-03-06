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

  def add_using post_it_hash
    post_it = PostIt.new  :text => post_it_hash['text'],
                          :top => post_it_hash['top'],
                          :left => post_it_hash['left'],
                          :group => post_it_hash['group']

    self.push :post_its => post_it.to_mongo

    post_it
  end

  def find id
    self.post_its.find(id)
  end

end

