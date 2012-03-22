require_relative 'spec_helper'
require_relative '../models/post_it'

describe "A PostIt", do

  before(:each) do
    @post_it = PostIt.new :group => "well", :text => "some_text", :left => "414", :top => "141"
  end

  it "should have a numeric id, group, text, left and top positions" do
    @post_it.should be_valid
  end

  context "positioning" do
    it "should not have left as letters" do
      post_it = PostIt.new :group => "well", :text => "some_text", :left => "some_letters", :top => "141"

      post_it.should_not be_valid
      post_it.errors.should have(1).messages
      post_it.errors.messages.should include({:left => ["is not a number"]})
    end

    it "should not have top as letters" do
      post_it = PostIt.new :group => "well", :text => "some_text", :left => "141", :top =>  "some_letters"

      post_it.should_not be_valid
      post_it.errors.should have(1).messages
      post_it.errors.messages.should include({:top => ["is not a number"]})
    end

  end

  context "group" do
    it "should be one of these valid values: 'bad', 'not_so_well', 'well', 'action_item'" do
      (PostIt.new :left => "414", :top => "414", :group => "bad").should be_valid
      (PostIt.new :left => "414", :top => "414", :group => "not_so_well").should be_valid
      (PostIt.new :left => "414", :top => "414", :group => "well").should be_valid
      (PostIt.new :left => "414", :top => "414", :group => "action_item").should be_valid
    end

    it "should not be anything crazy" do
      post_it = PostIt.new :left => "414", :top => "414", :group => "crazy"

      post_it.should_not be_valid
      post_it.errors.should have(1).messages
      post_it.errors.messages.should include({:group => ["is not included in the list"]})
    end
  end

end
