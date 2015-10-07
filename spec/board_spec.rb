require_relative 'spec_helper'
require_relative '../models/board'

describe "A Board" do

  before(:each) do
    @board = Board.create :name => "dasBoard"
  end

  it "should have a name" do
    expect(@board).to be_valid
  end

  it "should have an empty list of post its by default" do
    expect(@board.post_its).to be_empty
  end

  it "should not be missing a name" do
    @board.name = nil
    expect(@board).to_not be_valid
  end

  it "should not have the same name as other board" do
    another_board = Board.new :name => "dasBoard"

    expect(another_board).to_not be_valid
    expect(another_board.errors.messages.size).to eq(1)
    expect(another_board.errors.messages).to include({:name=>["has already been taken"]})
  end
end
