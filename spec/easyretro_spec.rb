require File.join(File.dirname(__FILE__), 'spec_helper')

describe "The EasyRetro app", :type => :api do

  let (:mongo) {  }

  xit "should create a board POST a json with a name" do
    post "/board", params = { 'name' => "theBoard" }, :format => :json

    last_response.status.should be 201
  end
end
