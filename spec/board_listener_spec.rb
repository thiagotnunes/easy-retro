require 'rspec'
require 'board_listener'

describe BoardListener, do

  before :each do
    @repo = double('repo')
    @callback = double('callback')
    @listener = BoardListener.new(@repo)
  end

  it "remove a post it" do
    message = {
      "channel" => "/board",
      "data" => {
        "action" => "remove",
        "board" => { "name" => "theBoard", "postIt" => { "id" => "1", "text" => "other text" } }
      }
    }

   @repo.should_receive(:get).with("theBoard").and_return({"postIts" => {"1" => {"id" => "1", "text" => "some text"}, "2" => {"id" => "2", "text" => "more text"}}})
   @repo.should_receive(:update).with({"postIts" => {"2" => {"id" => "2", "text" => "more text"}}})
    @callback.should_receive(:call).with(message) 
    @listener.outgoing message, @callback
  end
  it "should ignore messages without data" do
    message = {"id"=>"5", "clientId"=>"f0czplj7j6i1ujnse0cl38z0l", "channel"=>"/board", "successful"=>true}

    @callback.should_receive(:call).with(message) 
    @listener.outgoing message, @callback
  end
end
