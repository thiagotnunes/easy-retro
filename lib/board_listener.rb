require_relative 'boards'

class BoardListener

  def initialize(repo)
    @boards = repo
  end

  def outgoing(message, callback)
    if (message["channel"] == "/board")
      messageBoard = message["data"]["board"]
      name = messageBoard["name"]
      postIt = messageBoard["postIt"]

      board = @boards.get(name)
      board["postIts"] = {} if board["postIts"].nil?
      board["postIts"][postIt["id"]] = postIt

      @boards.update(board)
    end

    callback.call(message)
  end

end
