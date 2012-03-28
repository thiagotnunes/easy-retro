require File.join(File.dirname(__FILE__), 'spec_helper')

describe "The EasyRetro app", :type => :api do

  it "should create a board when POST a json with a name" do
    post "/board", params = { 'name' => "theBoard" }, :format => :json

    last_response.status.should == 201
    last_response.content_type.should match "json"
    last_response.body.should =~ /\{\"id\":\"\w+\",\"name\":\"theBoard\",\"post_its\":\[\]\}/

    Board.all.should have(1).item
    Board.find_by_name("theBoard").should be
  end

  it "should redirect to existing board when POST a json with a name already taken" do
    Board.create :name => "theBoard"

    post "/board", params = { 'name' => "theBoard" }, :format => :json

    last_response.status.should == 303

    Board.all.should have(1).item
    Board.find_by_name("theBoard").should be
  end

  it "should return a json representing a board when GET by name" do
    Board.create :name => "theBoard"

    get "/board/theBoard", :format => :json

    last_response.status.should == 200
    last_response.content_type.should match "json"
    last_response.body.should =~ /\{\"id\":\"\w+\",\"name\":\"theBoard\",\"post_its\":\[\]\}/
  end

  it "should create a post-it when POST to the a board's post-its" do
    Board.create :name => "theBoard"

    post "/board/theBoard/post_it",
      params = { 'text' => "some text", 'top' => 50, 'left' => 120, 'group' => 'well' },
      :format => :json

    last_response.status.should == 201
    last_response.content_type.should match "json"
    last_response.body.should =~ /\{\"group\":\"well\",\"id\":\"\w+\",\"left\":120,\"text\":\"some text\",\"top\":50\}/

    board = Board.find_by_name("theBoard")
    board.should have(1).post_it

    post_it = board.post_its.first
    post_it.text.should == "some text"
    post_it.top.should == 50
    post_it.left.should == 120
    post_it.group.should == "well"
  end

  it "should return a json representing a board's post-it when GET by id" do
    post_it = PostIt.new :group => "well", :text => "some_text", :left => "414", :top => "141"
    Board.create :name => "theBoard", :post_its => [post_it]

    get "/board/theBoard/post_it/#{post_it.id}", :format => :json

    last_response.status.should == 200
    last_response.content_type.should match "json"
    last_response.body.should =~ /\{\"group\":\"well\",\"id\":\"\w+\",\"left\":414,\"text\":\"some_text\",\"top\":141\}/
  end

  it "should delete a existing post-it and return a json representation when DELETE by id" do
    post_it = PostIt.new :group => "well", :text => "some_text", :left => "414", :top => "141"
    Board.create :name => "theBoard", :post_its => [post_it]

    delete "/board/theBoard/post_it/#{post_it.id}", :format => :json

    last_response.status.should == 200
    last_response.content_type.should match "json"
    last_response.body.should =~ /\{\"group\":\"well\",\"id\":\"\w+\",\"left\":414,\"text\":\"some_text\",\"top\":141\}/

    board = Board.find_by_name("theBoard")
    board.should have(0).post_its
    board.post_its.find(post_it.id).should_not be
  end

  it "should return a 404 NOT_FOUND when the post-it to delete does not exist" do
    Board.create :name => "theBoard", :post_its => []

    delete "/board/theBoard/post_it/123", :format => :json

    last_response.status.should == 404
  end
end
