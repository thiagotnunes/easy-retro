require File.join(File.dirname(__FILE__), 'easy_retro')
require File.join(File.dirname(__FILE__), 'init', 'mongo')

require 'faye'
use Faye::RackAdapter, :mount      => '/faye',
                       :timeout    => 25

require 'sass/plugin/rack'
use Sass::Plugin::Rack

run EasyRetroApp
