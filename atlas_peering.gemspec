# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "atlas_peering/version"

Gem::Specification.new do |spec|
  spec.name          = "atlas_peering"
  spec.version       = AtlasPeering::VERSION
  spec.authors       = ["Javier Juarez"]
  spec.email         = ["javier.juarez@gmail.com"]

  spec.summary       = %q{This cli helps creating a new peering connection against MongoDB Atlas service.}
  spec.description   = %q{This cli helps creating a new peering connection against MongoDB Atlas service.}
  spec.homepage      = "https://github.com/jjuarez/atlas_peering"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "httparty"
  spec.add_runtime_dependency "json"
  spec.add_runtime_dependency "awesome_print"

  spec.add_development_dependency "rubocop", "~> 0.52"
  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end

