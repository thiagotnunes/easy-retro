require 'sinatra'

get '/' do
    return File.open("public/wall.html")
end

get '/*' do |file|
    return File.open('public/' + file)
end


