require './lib/easy_retro'
require './lib/board_listener'
require 'faye'
require 'sinatra/mongo'

set :mongo, ENV['MONGOLAB_URI']

use Faye::RackAdapter, :mount      => '/faye',
                       :timeout    => 25,
                       :extensions => [BoardListener.new]

run EasyRetroApp
