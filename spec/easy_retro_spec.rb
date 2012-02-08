require 'easy_retro'
require 'rspec'
require 'rack/test'

describe 'Easy retro base app' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "should say a welcome message when accessing home page" do
    get '/'
    last_response.should be_ok
  end
end
