# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'terraform/utils/version'

Gem::Specification.new do |spec|
  spec.name          = "terraform-utils"
  spec.version       = Terraform::Utils::VERSION
  spec.authors       = ["John Engelman"]
  spec.email         = ["john.r.engelman@gmail.com"]
  spec.summary       = "Provides utility libraries for dealing with Terraform state files"
  spec.description   = "Provides utility libraries for dealing with Terraform state files"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `ls`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
