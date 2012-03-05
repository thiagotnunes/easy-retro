require 'mongo'

class Boards
  def initialize(db)
    @db = db
  end

  def insert(board)
    @db.insert(board) unless @db.find_one(:name => board['name'])
  end

  def update(board)
    @db.update({ :name => board['name'] }, board)
  end

  def get(name)
    board = @db.find_one(:name => name)
    if (board)
      board["postIts"] = {} if board["postIts"].nil?
    end
    board
  end
end                                                                 

