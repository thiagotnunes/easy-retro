require_relative 'boards'

class BoardListener

  attr_reader :postIts 

  def initialize(mongo)
    @boards = BoardRepo.new
  end

  def outgoing(message, callback)
    if (message["channel"] == "/board")
      name = message["data"]["board"]
      postIt = message["data"]["postIt"]
      board = @boards.get(name)
      board["postIts"] = {} if board["postIts"].nil?
      board["postIts"][postIt["id"]] = postIt

      @boards.update(board)
    end

    callback.call(message)
  end

end
