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

    board.send "#{action}_post_it".to_sym, message["post_it"] if (action != "removed" && action != "updated")

    board.save
  end

end
