# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "kubes/version"

Gem::Specification.new do |spec|
  spec.name          = "kubes"
  spec.version       = Kubes::VERSION
  spec.authors       = ["Tung Nguyen"]
  spec.email         = ["tung@boltops.com"]
  spec.summary       = "Kubernetes Deployment Tool: build docker image, compile Kubernetes YAML files, and apply them"
  spec.homepage      = "https://github.com/boltops-tools/kubes"
  spec.license       = "Apache2.0"

  spec.files         = File.directory?('.git') ? `git ls-files`.split($/) : Dir.glob("**/*")
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport"
  spec.add_dependency "deep_merge"
  spec.add_dependency "dsl_evaluator"
  spec.add_dependency "hash_squeezer"
  spec.add_dependency "memoist"
  spec.add_dependency "nokogiri"
  spec.add_dependency "rainbow"
  spec.add_dependency "render_me_pretty"
  spec.add_dependency "thor"
  spec.add_dependency "zeitwerk"

  # core helper libs
  spec.add_dependency "kubes_aws", ">= 0.3.1"
  spec.add_dependency "kubes_google", ">= 0.3.8"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "cli_markdown"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["homepage_uri"] = spec.homepage
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end
end
