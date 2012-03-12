Dir["./models/**/*.rb"].each { |model| require model }

class BoardListener

  def outgoing message, callback
    data = message["data"]
    if (data)
      execute data["action"], data["board"]
    end

    callback.call(message)
  end

  def execute action, message
    board = Board.find_by_name(message["name"])

    post_it = message["post_it"]

    if (action == "remove")
      board.remove_post_it post_it
    elsif (action == "create")
      board.create_post_it post_it
    else
      board.update_post_it post_it
    end
    board.save
  end

end
