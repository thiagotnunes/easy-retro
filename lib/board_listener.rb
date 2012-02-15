class BoardListener
  attr_reader :postIts 
  def initialize
    @postIts = Hash.new 
  end

  def outgoing (message, callback)
    p "outgoing: #{message}"
    if (message["channel"] == "meta/subscribe")
      message["ext"] = @postIts
    end
    if message["channel"] == "/board"
      data = message["data"]
      @postIts[data["id"]] = data
    end
    callback.call(message)
  end

end
