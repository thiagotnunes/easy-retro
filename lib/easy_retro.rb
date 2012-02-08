require 'sinatra'

class EasyRetroApp < Sinatra::Base

  get '/' do
      return File.open("public/index.html")
  end

  get '/*' do |file|
      return File.open('public/' + file)
  end

end
