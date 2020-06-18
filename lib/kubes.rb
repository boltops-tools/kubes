$:.unshift(File.expand_path("../", __FILE__))
require "active_support/core_ext/hash"
require "dsl_evaluator"
require "fileutils"
require "hash_squeezer"
require "kubes/version"
require "memoist"
require "rainbow/ext/string"
require "yaml"

DslEvaluator.backtrace_reject = ".kubes"

require "kubes/autoloader"
Kubes::Autoloader.setup

module Kubes
  class Error < StandardError; end
  extend Core
end
