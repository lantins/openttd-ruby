$:.unshift(File.expand_path(File.dirname(__FILE__))) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'digest/md5'
require 'date'
require 'ipaddr'
require 'bindata'
require 'eventmachine'
require 'hashie'

module OpenTTD
    MASTER_SERVER_VERSION = 2
    MASTER_SERVER_HOST    = 'master.openttd.org'
    CONTENT_SERVER_HOST   = 'content.openttd.org'
    MASTER_SERVER_PORT    = 3978
    CONTENT_SERVER_PORT   = 3978
end

require 'openttd/encoding'
require 'openttd/data_type'
require 'openttd/payload'
require 'openttd/packet'
require 'openttd/client'
require 'openttd/version'