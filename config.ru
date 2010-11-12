$LOAD_PATH.push File.join(File.expand_path(File.dirname(__FILE__)))
require "gruff_server"
run Sinatra::Application

# vi:ft=ruby
