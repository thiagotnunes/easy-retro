require File.join(File.dirname(__FILE__), 'easy_retro')

require File.join(File.dirname(__FILE__), 'init', 'scss')
require File.join(File.dirname(__FILE__), 'init', 'mongo')

require 'faye'
use Faye::RackAdapter, :mount      => '/faye',
                       :timeout    => 25,
                       :extensions => [BoardListener.new(Board.new(mongo['boards']))]

run EasyRetroApp
