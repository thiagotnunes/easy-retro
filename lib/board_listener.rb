Dir["./models/**/*.rb"].each { |model| require model }

class BoardListener

  def outgoing message, callback 
    data = message["data"]
    if (data)
      execute data["action"], data["board"]
    end

    callback.call(message)
  end

  def execute action, messageBoard
    name = messageBoard["name"]
    board = Board.find_by_name(name)
    postIt = messageBoard["postIt"]
    if (action == "remove")
      board.post_its.delete_if {|p| p[:id] == postIt["id"]}
    elsif (action == "create")
      board.post_its << PostIt.new(:id => postIt["id"], :group => postIt["group"], :left => postIt["left"], :top => postIt["top"], :text => postIt["text"])
    else
      board.post_its.select {|p| p[:id] == postIt["id"]}.each do |p|
        p.group = postIt["group"]
        p.text = postIt["text"]
        p.left = postIt["left"]
        p.top = postIt["top"]
      end
    end
    board.save
  end

end
