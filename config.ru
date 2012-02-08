require './lib/easy_retro'
require 'faye'

use Faye::RackAdapter, :mount      => '/faye',
                       :timeout    => 25

run EasyRetroApp
