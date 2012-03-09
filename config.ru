require File.join(File.dirname(__FILE__), 'easy_retro')
require 'faye'
require 'sinatra/mongo'

set :mongo, ENV['MONGOLAB_URI'] || "mongo://localhost:27017/easy_retro"

use Faye::RackAdapter, :mount      => '/faye',
                       :timeout    => 25,
                       :extensions => [BoardListener.new(Board.new(mongo['boards']))]

run EasyRetroApp
