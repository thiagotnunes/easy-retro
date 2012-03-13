require_relative 'spec_helper'
require_relative '../models/board'
require_relative '../lib/board_listener'

describe BoardListener, do
  let(:listener) { BoardListener.new() }

  before :each do
    @callback = double('callback')
    @board = double("board")
  end

  it "call updates the board according to an action" do
    
    post_it = {"id" => "2", "text" => "updated text"}
    message = {
      "data" => {
        "action" => "update",
        "board" => { "name" => "theBoard", "post_it" => post_it }
      }
    }

    Board.stub(:find_by_name).with("theBoard").and_return(@board)

    @board.should_receive(:send).with(:update_post_it, post_it)
    @board.should_receive(:save)
    @callback.should_receive(:call).with(message)
    listener.outgoing message, @callback
  end

  it "should ignore messages without data" do
    message = {"id"=>"5", "clientId"=>"f0czplj7j6i1ujnse0cl38z0l", "channel"=>"/board", "successful"=>true}

    Board.stub(:find_by_name).with("theBoard").and_return(@board)

    @board.should_not_receive(:send)
    @callback.should_receive(:call).with(message)
    listener.outgoing message, @callback
  end
end
