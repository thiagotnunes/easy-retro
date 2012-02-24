require_relative 'boards'

class BoardListener

  def initialize(repo)
    @boards = repo
  end

  def outgoing(message, callback)
    data = message["data"]
    if (message["channel"] == "/board" && data)
      action = data["action"]

      messageBoard = data["board"]
      name = messageBoard["name"]
      board = @boards.get(name)
      board["postIts"] = {} if board["postIts"].nil?
      postIt = messageBoard["postIt"]
      if (action == "remove")
        board["postIts"].delete(postIt["id"])
      elsif
        board["postIts"][postIt["id"]] = postIt
      end
      @boards.update(board)
    end

    callback.call(message)
  end

end
