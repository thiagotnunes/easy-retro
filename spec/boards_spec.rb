require 'rspec'
require 'boards'

describe Boards, do

  before :each do
    @board = {"name" => "theBoard" }
    @mongo = double('mongo')
    @boards = Boards.new(@mongo)
  end

  it "should insert a new board" do
    @mongo.should_receive(:find_one).with(:name => "theBoard").and_return(false)
    @mongo.should_receive(:insert).with(@board).and_return(@board)
    
    @boards.insert(@board).should be @board
  end

  it "should not duplicate an existing board" do
    @mongo.should_receive(:find_one).with(:name => "theBoard").and_return(true)
    @mongo.should_not_receive(:insert).with(@board).and_return(@board)
    
    @boards.insert(@board)
  end

  it "should update a board" do
    @mongo.should_receive(:update).with({ :name => "theBoard" }, @board)

    @boards.update(@board)
  end

  it "should get a board" do
   @mongo.should_receive(:find_one).with(:name => "theBoard") 

   @boards.get("theBoard")
  end

end
