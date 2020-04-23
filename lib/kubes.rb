$:.unshift(File.expand_path("../", __FILE__))
require "kubes/version"
require "memoist"
require "rainbow/ext/string"

require "kubes/autoloader"
Kubes::Autoloader.setup

module Kubes
  class Error < StandardError; end
end
