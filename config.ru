require './lib/easy_retro'
require 'faye'
require 'sinatra/mongo'

set :mongo, ENV['MONGOHQ_URL']

use Faye::RackAdapter, :mount      => '/faye',
                       :timeout    => 25

run EasyRetroApp
