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

  context "post-its" do
    it "can be created from a hash" do
      post_it = {"id" => "1", "text" => "some text"}
      @board.create_post_it post_it

      @board.should have(1).post_it
      @board.post_its.first.id.should == "1"
      @board.post_its.first.text.should == "some text"
    end

    it "can be updated from a hash" do
      post_it = PostIt.new :left => "414", :top => "414", :group => "well", :text => "original text"
      post_it_to_update = {"id" => post_it.id, "text" => "updated text"}
      @board.post_its << post_it

      @board.update_post_it post_it_to_update

      @board.should have(1).post_it
      @board.post_its.first.id.should == post_it.id
      @board.post_its.first.text.should == "updated text"
    end

  end

end
