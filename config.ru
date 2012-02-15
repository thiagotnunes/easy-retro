require './lib/easy_retro'
require 'faye'
require 'sinatra/mongo'

set :mongo, ENV['MONGOLAB_URI']

use Faye::RackAdapter, :mount      => '/faye',
                       :timeout    => 25

run EasyRetroApp
