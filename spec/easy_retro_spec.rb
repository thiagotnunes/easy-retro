require File.join(File.dirname(__FILE__), 'spec_helper')

describe "The EasyRetro app", :type => :api do

  it "should create a board when POST a json with a name" do
    post "/board", params = { 'name' => "theBoard" }, :format => :json

    last_response.status.should be 201
    last_response.content_type.should match "json"
    last_response.body.should =~ /\{\"id\":\"\w+\",\"name\":\"theBoard\",\"post_its\":\[\]\}/

    Board.all.should have(1).item
    Board.find_by_name("theBoard").should be
  end

  it "should redirect to existing board when POST a json with a name already taken" do
    Board.create :name => "theBoard"

    post "/board", params = { 'name' => "theBoard" }, :format => :json

    last_response.status.should be 302

    Board.all.should have(1).item
    Board.find_by_name("theBoard").should be
  end

  it "should return a json representing a board when GET by name" do
    Board.create :name => "theBoard"

    get "/board/theBoard", :format => :json

    last_response.status.should be 200
    last_response.content_type.should match "json"
    last_response.body.should =~ /\{\"id\":\"\w+\",\"name\":\"theBoard\",\"post_its\":\[\]\}/
  end
end
