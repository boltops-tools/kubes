$stdout.sync = true unless ENV["KUBES_STDOUT_SYNC"] == "0"

$:.unshift(File.expand_path("../", __FILE__))

require "kubes/autoloader"
Kubes::Autoloader.setup

require "active_support/core_ext/class"
require "active_support/core_ext/hash"
require "active_support/core_ext/string"
require "active_support/ordered_options"
require "deep_merge/rails_compat"
require "dsl_evaluator"
require "fileutils"
require "hash_squeezer"
require "kubes/version"
require "memoist"
require "rainbow/ext/string"
require "yaml"

# core helper libraries
require "kubes_aws"
require "kubes_google"

DslEvaluator.backtrace_reject = "lib/kubes"

module Kubes
  class Error < StandardError; end
  class MissingDockerImage < Error; end
  extend Core
end
