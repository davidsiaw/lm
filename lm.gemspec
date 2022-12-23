# frozen_string_literal: true

require_relative "lib/lm/version"

Gem::Specification.new do |spec|
  spec.name = "lm"
  spec.version = Lm::VERSION
  spec.authors = ["David Siaw"]
  spec.email = ["davidsiaw@gmail.com"]

  spec.summary = "Logic Minimizer"
  spec.description = "Logic Minimizer Library"
  spec.homepage = "https://github.com/davidsiaw/lm"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/davidsiaw/lm"
  spec.metadata["changelog_uri"] = "https://github.com/davidsiaw/lm"

  spec.files         = Dir["{data,exe,lib,bin}/**/*"] + %w[Gemfile lm.gemspec]
  spec.test_files    = Dir["spec/**/*"]
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
