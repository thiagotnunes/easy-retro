require_relative 'spec_helper'
require_relative '../models/board'

describe "A Board", do

  before(:each) do
    @board = Board.create :name => "dasBoard"
  end

  it "should have a name" do
    @board.should be_valid
  end

  it "should have an empty list of post its by default" do
    @board.post_its.should be_empty
  end

  it "should not be missing a name" do
    @board.name = nil
    @board.should_not be_valid
  end

  it "should not have the same name as other board" do
    another_board = Board.new :name => "dasBoard"

    another_board.should_not be_valid
    another_board.errors.should have(1).messages
    another_board.errors.messages.should include({:name=>["has already been taken"]})
  end

end
