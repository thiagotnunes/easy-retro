require 'rspec'
require 'board_listener'

describe BoardListener, do

  before :each do
    @repo = double('repo')
    @callback = double('callback')
    @listener = BoardListener.new(@repo)
  end

  it "should add new post it for a board without post its" do
    message = {
      "channel" => "/board",
      "data" => {
        "action" => "create",
        "board" => {
          "name" => "theBoard",
          "postIt" => {
            "id" => "1",
            "text" => "other text"
          }
        }
      }
    }

   @repo.should_receive(:get).with("theBoard").and_return({})
   @repo.should_receive(:update).with({"postIts" => {"1" => {"id" => "1", "text" => "other text"}}})
   @callback.should_receive(:call).with(message) 

   @listener.outgoing message, @callback
  end

  it "should update post it for a board with the given post it" do
    message = {
      "channel" => "/board",
      "data" => {
        "action" => "create",
        "board" => {
          "name" => "theBoard",
          "postIt" => {
            "id" => "1",
            "text" => "other text"
          }
        }
      }
    }

   @repo.should_receive(:get).with("theBoard").and_return({"postIts" => {"1" => {"id" => "1", "text" => "some text"}}})
   @repo.should_receive(:update).with({"postIts" => {"1" => {"id" => "1", "text" => "other text"}}})
   @callback.should_receive(:call).with(message) 

   @listener.outgoing message, @callback
  end

end
