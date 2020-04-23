$:.unshift(File.expand_path("../", __FILE__))
require "kubes/version"
require "memoist"
require "rainbow/ext/string"

gem_root = File.dirname(__dir__)
$:.unshift("#{gem_root}/lib")
$:.unshift("#{gem_root}/vendor/evaluate_file/lib")
require "evaluate_file"

require "kubes/autoloader"
Kubes::Autoloader.setup

module Kubes
  class Error < StandardError; end
end
