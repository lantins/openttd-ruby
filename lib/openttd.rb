$:.unshift(File.expand_path(File.dirname(__FILE__))) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'bindata'

require 'openttd/encoding'
require 'openttd/payload'
require 'openttd/packet'