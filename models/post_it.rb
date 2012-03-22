require 'mongo_mapper'

class PostIt
  include MongoMapper::EmbeddedDocument

  GROUPS = ["bad", "not_so_well", "well", "action_item"]

  key :group, String, :in => GROUPS
  key :text, String
  key :left, Integer, :numeric => true
  key :top, Integer, :numeric => true

  embedded_in :board

  def eql?(other)
    self.class.eql?(other.class) &&
       id == other.id &&
       group == other.group &&
       text == other.text &&
       left == other.left &&
       top == other.top
  end
  alias :== :eql?

end
