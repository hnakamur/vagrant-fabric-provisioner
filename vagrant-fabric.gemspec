# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vagrant-fabric/version'

Gem::Specification.new do |spec|
  spec.name          = "vagrant-fabric"
  spec.version       = VagrantPlugins::Fabric::VERSION
  spec.platform      = Gem::Platform::RUBY
  spec.authors       = ["Takahiro Fujiwara"]
  spec.email         = ["wutali.no@gmail.com"]
  spec.homepage      = "http://blog.wuta.li"
  spec.description   = "Enables Vagrant to provision with python fabric script."
  spec.summary       = "Enables Vagrant to provision with python fabric script."
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
