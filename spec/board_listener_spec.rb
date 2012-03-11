require_relative 'spec_helper'
require_relative '../models/board'
require_relative '../lib/board_listener'

describe BoardListener, do
  let(:some_text_post_it) { PostIt.new :id => 1, :text => "some text" }
  let(:more_text_post_it) { PostIt.new :id => 2, :text => "more text" }
  let(:listener) { BoardListener.new() }

  before :each do
    @board = Board.create :name => "theBoard", :post_its => [some_text_post_it, more_text_post_it] 
    @callback = double('callback')
  end

  it "should remove a post it" do
    message = {
      "channel" => "/board",
      "data" => {
        "action" => "remove",
        "board" => { "name" => "theBoard", "postIt" => { "id" => "1", "text" => "other text" } }
      }
    }

    @callback.should_receive(:call).with(message) 
    listener.outgoing message, @callback

    updated_board = Board.find_by_name "theBoard"

    updated_board.post_its.should have(1).item
    updated_board.post_its.first.should == more_text_post_it
  end

  it "should ignore messages without data" do
    message = {"id"=>"5", "clientId"=>"f0czplj7j6i1ujnse0cl38z0l", "channel"=>"/board", "successful"=>true}

    @callback.should_receive(:call).with(message) 
    listener.outgoing message, @callback

    updated_board = Board.find_by_name "theBoard"

    updated_board.post_its.should have(2).items
  end
end
