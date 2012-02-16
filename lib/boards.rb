require 'mongo'

class BoardRepo
    def initialize
        @db = mongo['boards']
    end

    def insert(board)
        @db.insert(board) unless @db.find_one(:name => board['name'])
    end

    def update(board)
        @db.update({ 'name' => board['name'] }, board)
    end

    def get(name)
        @db.find_one(:name => name)
    end
end                                                                 

