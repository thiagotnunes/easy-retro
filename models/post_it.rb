require 'mongo_mapper'

class PostIt
  include MongoMapper::EmbeddedDocument

  GROUPS = ["bad", "not_so_well", "well", "action_item"]

  key :id, String, :required => true, :numeric => true
  key :group, String, :in => GROUPS
  key :text, String
  key :left, Integer
  key :top, Integer

  embedded_in :board

end
