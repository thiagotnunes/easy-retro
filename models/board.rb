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

  def create_post_it post_it
    self.post_its << PostIt.new(post_it)
  end

  def update_post_it post_it
    self.post_its.select {|p| p[:id] == post_it["id"]}.each do |p|
      p.group = post_it["group"]
      p.text = post_it["text"]
      p.left = post_it["left"]
      p.top = post_it["top"]
    end
  end

  def remove_post_it post_it
    self.post_its.delete_if {|p| p[:id] == post_it["id"]}
  end
end

