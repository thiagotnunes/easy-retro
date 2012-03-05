require_relative 'boards'

class BoardListener

  def initialize(repo)
    @boards = repo
  end

  def outgoing message, callback 
    data = message["data"]
    if (data)
      execute data["action"], data["board"]
    end

    callback.call(message)
  end

  def execute action, messageBoard
    name = messageBoard["name"]
    board = @boards.get(name)
    postIt = messageBoard["postIt"]
    if (action == "remove")
      board["postIts"].delete(postIt["id"])
    elsif
      board["postIts"][postIt["id"]] = postIt
    end
    @boards.update(board)
  end

end
