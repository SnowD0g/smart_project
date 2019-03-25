
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "smart_project/version"

Gem::Specification.new do |spec|
  spec.name          = "smart_project"
  spec.version       = SmartProject::VERSION
  spec.authors       = ["Marco Iannantuono"]
  spec.email         = ["marco.iannantuono@democom.it"]
  spec.summary       = 'smart_project libraries for services interaction'
  spec.description   = 'Shared behavior for integrate services in the SmartWork Project Environment'
  spec.require_paths = ["lib", "lib/smart_project"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
