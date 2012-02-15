require 'rspec'
require 'board_listener'

describe 'BoardListener' do
  before(:each) do
    @listener = BoardListener.new 
    @callback = double('callback')
  end
  it "should save publihed post its" do
    message = {"channel" => "/board", "data" => {"id" => "123_4", "text" => "some text"}}

    @callback.should_receive(:call).with(message)
    @listener.outgoing message, @callback 
    @listener.postIts['123_4'].should eq message["data"] 
  end
  it "should return the current board when subscribing to a channel" do
    first_message = {"channel" => "/board", "data" => {"id" => "1", "text" => "some text"}}
    @callback.should_receive(:call).with(first_message)
    @listener.outgoing first_message, @callback
    second_message = {"channel" => "/board", "data" => {"id" => "2", "text" => "more text"}}
    @callback.should_receive(:call).with(second_message)
    @listener.outgoing second_message, @callback

    subscribe_message = {"channel" => "meta/subscribe"}
    expected_message = {"channel" => "meta/subscribe", "ext" => {"1" => {"id" => "1", "text" => "some text"}, "2" => {"id" => "2", "text" => "more text"}}}
    @callback.should_receive(:call).with(expected_message)
    @listener.outgoing subscribe_message, @callback
  end
  it "should ignore other messages" do
    
    message = {"channel" => "/meta/connect"}

    @callback.should_receive(:call).with(message)
    @listener.outgoing message, @callback 
    @listener.postIts.should be_empty
  end
end
