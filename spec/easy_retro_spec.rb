require 'easy_retro'
require 'rspec'
require 'rack/test'

describe 'Easy retro base app' do
  include Rack::Test::Methods

  def app
    EasyRetroApp
  end

end
