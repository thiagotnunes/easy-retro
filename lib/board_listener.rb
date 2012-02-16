class BoardListener

  attr_reader :postIts 

  def initialize(mongo)
    @boards = mongo["boards"]
  end

  def outgoing(message, callback)
    if (message["channel"] == "/board")
      name = message["data"]["board"]
      postIt = message["data"]["postIt"]
      board = @boards.find_one({name: name})
      board["postIts"] = {} if board["postIts"].nil?
      board["postIts"][postIt["id"]] = postIt

      @boards.update({name: name}, board)
    end

    callback.call(message)
  end

end
