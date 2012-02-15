require 'easy_retro'
require 'rspec'
require 'rack/test'

describe 'Easy retro base app' do
  include Rack::Test::Methods

  def app
    EasyRetroApp
  end

  it "should return code 200 when accessing home page" do
    get '/'
    last_response.should be_ok
  end
end
