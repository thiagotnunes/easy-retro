require './app'
require './lib/board_listener'
require './lib/boards'
require 'faye'
require 'sinatra/mongo'

set :mongo, ENV['MONGOLAB_URI'] || "mongo://localhost:27017/easy_retro"

use Faye::RackAdapter, :mount      => '/faye',
                       :timeout    => 25

run EasyRetroApp
