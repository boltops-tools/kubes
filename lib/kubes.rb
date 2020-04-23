$:.unshift(File.expand_path("../", __FILE__))
require "active_support/core_ext/hash"
require "fileutils"
require "kubes/version"
require "memoist"
require "rainbow/ext/string"
require "yaml"

gem_root = File.dirname(__dir__)
$:.unshift("#{gem_root}/lib")
$:.unshift("#{gem_root}/vendor/evaluate_file/lib")
require "evaluate_file"
$:.unshift("#{gem_root}/vendor/hash_squeezer/lib")
require "hash_squeezer"

require "kubes/autoloader"
Kubes::Autoloader.setup

module Kubes
  class Error < StandardError; end
  extend Core
end
