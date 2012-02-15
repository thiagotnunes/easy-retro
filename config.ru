require './lib/easy_retro'
require './lib/board_listener'
require 'faye'

use Faye::RackAdapter, :mount      => '/faye',
                       :timeout    => 25,
                       :extensions => [BoardListener.new]

run EasyRetroApp
