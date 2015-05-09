# coding: utf-8
lib_dir = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)
require "oooxxx/version"

Gem::Specification.new do |spec|
  spec.name          = "oooxxx"
  spec.version       = Oooxxx::VERSION
  spec.authors       = ["Masafumi Yokoyama"]
  spec.email         = ["yokoyama@clear-code.com"]
  spec.summary       = %q{TODO: Write a short summary, because Rubygems requires one.}
  spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) {|f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency("onsengame", ">= 0.0.5")

  spec.add_development_dependency("bundler")
  spec.add_development_dependency("rake")
end
