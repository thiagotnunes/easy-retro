require_relative 'spec_helper'
require_relative '../models/post_it'

describe "A PostIt" do

  before(:each) do
    @post_it = PostIt.new :group => "well", :text => "some_text", :left => "414", :top => "141"
  end

  it "should have a numeric id, group, text, left and top positions" do
    expect(@post_it).to be_valid
  end

  context "positioning" do
    it "should not have left as letters" do
      post_it = PostIt.new :group => "well", :text => "some_text", :left => "some_letters", :top => "141"

      expect(post_it).to_not be_valid
      expect(post_it.errors.messages.size).to eq(1)
      expect(post_it.errors.messages).to include({:left => ["is not a number"]})
    end

    it "should not have top as letters" do
      post_it = PostIt.new :group => "well", :text => "some_text", :left => "141", :top =>  "some_letters"

      expect(post_it).to_not be_valid
      expect(post_it.errors.messages.size).to eq(1)
      expect(post_it.errors.messages).to include({:top => ["is not a number"]})
    end

  end

  context "group" do
    it "should be one of these valid values: 'bad', 'not_so_well', 'well', 'action_item'" do
      expect(PostIt.new :left => "414", :top => "414", :group => "bad").to be_valid
      expect(PostIt.new :left => "414", :top => "414", :group => "not_so_well").to be_valid
      expect(PostIt.new :left => "414", :top => "414", :group => "well").to be_valid
      expect(PostIt.new :left => "414", :top => "414", :group => "action_item").to be_valid
    end

    it "should not be anything crazy" do
      post_it = PostIt.new :left => "414", :top => "414", :group => "crazy"

      expect(post_it).to_not be_valid
      expect(post_it.errors.messages.size).to eq(1)
      expect(post_it.errors.messages).to include({:group => ["is not included in the list"]})
    end
  end
end
