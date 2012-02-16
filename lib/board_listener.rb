class BoardListener

  attr_reader :postIts 

  def initialize
    @postIts = Hash.new 
  end

  def outgoing(message, callback)
    if (message["channel"] == "/meta/subscribe")
      message["ext"] = @postIts
    end

    if (message["channel"] == "/board")
      postIt = message["data"]["postIt"]
      @postIts[postIt["id"]] = postIt
    end

    callback.call(message)
  end

end
