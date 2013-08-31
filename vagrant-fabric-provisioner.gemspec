# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vagrant-fabric-provisioner/version'

Gem::Specification.new do |spec|
  spec.name          = "vagrant-fabric-provisioner"
  spec.version       = Vagrant::Fabric::Provisioner::VERSION
  spec.authors       = ["Hiroaki Nakamura"]
  spec.email         = ["hnakamur@gmail.com"]
  spec.description   = %q{vagrant fabric provisioner}
  spec.summary       = spec.description
  spec.homepage      = "https://rubygems.org/gems/vagrant-fabric-provisioner"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
