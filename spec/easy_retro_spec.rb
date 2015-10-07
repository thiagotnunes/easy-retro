require File.join(File.dirname(__FILE__), 'spec_helper')

describe "The EasyRetro app", :type => :api do

  describe "when interacting with boards" do
    it "should return a template for the board using a name" do
      Board.create :name => "theBoard"

      get "/theBoard"

      expect(last_response.status).to eq(200)
      expect(last_response.content_type).to match "html"
      expect(last_response.body).to include("<title>Easy-Retro: theBoard</title>")
      expect(last_response.body).to include("<script>var boardName = \"theBoard\";</script>")
    end
  end

  describe "when providing api for boards" do
    it "should create a board when POST a json with a name" do
      post "/board", { 'name' => "theBoard" }, :format => :json

      expect(last_response.status).to eq(201)
      expect(last_response.content_type).to match "json"
      expect(last_response.body).to match(/\{\"id\":\"\w+\",\"name\":\"theBoard\",\"post_its\":\[\]\}/)

      expect(Board.all.size).to eq(1)
      expect(Board.find_by_name("theBoard")).to be
    end

    it "should redirect to existing board when POST a json with a name already taken" do
      Board.create :name => "theBoard"

      post "/board", { 'name' => "theBoard" }, :format => :json

      expect(last_response.status).to eq(303)

      expect(Board.count).to eq(1)
      expect(Board.find_by_name("theBoard")).to be
    end

    it "should return a json representing a board when GET by name" do
      Board.create :name => "theBoard"

      get "/board/theBoard", :format => :json

      expect(last_response.status).to eq(200)
      expect(last_response.content_type).to match "json"
      expect(last_response.body).to match(/\{\"id\":\"\w+\",\"name\":\"theBoard\",\"post_its\":\[\]\}/)
    end
  end

  describe "when providing api for post-its" do
    it "should create a post-it when POST to the a board's post-its" do
      Board.create :name => "theBoard"

      post "/board/theBoard/post_it",
        { 'post_it' => { 'text' => "some text", 'top' => 50, 'left' => 120, 'group' => 'well' }},
        :format => :json

      expect(last_response.status).to eq(201)
      expect(last_response.content_type).to match("json")
      expect(last_response.body).to match(/\{\"group\":\"well\",\"id\":\"\w+\",\"left\":120,\"text\":\"some text\",\"top\":50\}/)

      board = Board.find_by_name("theBoard")
      expect(board.post_its.size).to eq(1)

      post_it = board.post_its.first
      expect(post_it.text).to eq("some text")
      expect(post_it.top).to eq(50)
      expect(post_it.left).to eq(120)
      expect(post_it.group).to eq("well")
    end

    it "should return a json representing a board's post-it when GET by id" do
      post_it = PostIt.new :group => "well", :text => "some_text", :left => "414", :top => "141"
      Board.create :name => "theBoard", :post_its => [post_it]

      get "/board/theBoard/post_it/#{post_it.id}", :format => :json

      expect(last_response.status).to eq(200)
      expect(last_response.content_type).to match("json")
      expect(last_response.body).to match(/\{\"group\":\"well\",\"id\":\"\w+\",\"left\":414,\"text\":\"some_text\",\"top\":141\}/)
    end

    it "should return a 404 NOT_FOUND when GET a post-it that do not exist" do
      Board.create :name => "theBoard", :post_its => []

      get "/board/theBoard/post_it/123", :format => :json

      expect(last_response.status).to eq(404)
    end

    it "should update a post-it when PUT to the a board's post-its using id" do
      post_it = PostIt.new :group => "well", :text => "some_text", :left => "414", :top => "141"
      Board.create :name => "theBoard", :post_its => [post_it]

      put "/board/theBoard/post_it/#{post_it.id}",
      { 'post_it' => {'text' => "some text", 'top' => 50, 'left' => 120, 'group' => 'well' }},
      :format => :json

      expect(last_response.status).to eq(200)
      expect(last_response.content_type).to match("json")
      expect(last_response.body).to match(/\{\"group\":\"well\",\"id\":\"#{post_it.id}\",\"left\":120,\"text\":\"some text\",\"top\":50\}/)

      board = Board.find_by_name("theBoard")
      expect(board.post_its.size).to eq(1)

      post_it = board.post_its.first
      expect(post_it.text).to eq("some text")
      expect(post_it.top).to eq(50)
      expect(post_it.left).to eq(120)
      expect(post_it.group).to eq("well")
    end

    it "should return a 404 NOT_FOUND when updating PUT a the post-it that does not exist" do
      Board.create :name => "theBoard", :post_its => []

      put "/board/theBoard/post_it/123", :format => :json

      expect(last_response.status).to eq(404)
    end

    it "should delete a existing post-it and return a json representation when DELETE by id" do
      post_it = PostIt.new :group => "well", :text => "some_text", :left => "414", :top => "141"
      Board.create :name => "theBoard", :post_its => [post_it]

      delete "/board/theBoard/post_it/#{post_it.id}", :format => :json

      expect(last_response.status).to eq(200)
      expect(last_response.content_type).to match("json")
      expect(last_response.body).to match(/\{\"group\":\"well\",\"id\":\"\w+\",\"left\":414,\"text\":\"some_text\",\"top\":141\}/)

      board = Board.find_by_name("theBoard")
      expect(board.post_its.size).to eq(0)
      expect(board.post_its.find(post_it.id)).to_not be
    end

    it "should return a 404 NOT_FOUND when the post-it to delete does not exist" do
      Board.create :name => "theBoard", :post_its => []

      delete "/board/theBoard/post_it/123", :format => :json

      expect(last_response.status).to eq(404)
    end
  end
end
