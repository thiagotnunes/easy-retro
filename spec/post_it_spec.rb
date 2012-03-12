require_relative 'spec_helper'
require_relative '../models/post_it'

describe "A PostIt", do

  before(:each) do
    @post_it = PostIt.new :id => "123", :group => "well", :text => "some_text", :left => "414", :top => "141"
  end

  it "should have a numeric id" do
    @post_it.should be_valid
  end

  it "should not have letters as id" do
    @post_it = PostIt.new :id => "iiiii", :group => "well"

    @post_it.should_not be_valid
    @post_it.errors.should have(1).messages
    @post_it.errors.messages.should include({:id=>["is not a number"]})
  end

  it "should not be missing the id" do
    @post_it = PostIt.new :id => nil, :group => "well"

    @post_it.should_not be_valid
    @post_it.errors.should have(1).messages
    @post_it.errors.messages.should include({:id=>["can't be blank", "is not a number"]})
  end

  context "group" do
    it "should be one of the valid values" do
      (PostIt.new :id => "1", :group => "bad").should be_valid
      (PostIt.new :id => "1", :group => "not_so_well").should be_valid
      (PostIt.new :id => "1", :group => "well").should be_valid
      (PostIt.new :id => "1", :group => "action_item").should be_valid
    end

    it "should not be anything crazy" do
      post_it = PostIt.new :id => "1", :group => "crazy"

      post_it.should_not be_valid
      post_it.errors.should have(1).messages
      post_it.errors.messages.should include({:group=>["is not included in the list"]})
    end
  end

end
