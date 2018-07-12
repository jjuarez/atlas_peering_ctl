# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'atlas'

Gem::Specification.new do |spec|
  spec.name          = 'atlas_peering_ctl'
  spec.version       = ::Atlas::VERSION
  spec.authors       = ['Javier Juarez']
  spec.email         = ['javier.juarez@gmail.com']

  spec.summary       = 'This cli helps to handle peering connectons with MongoDB Atlas service.'
  spec.description   = 'This cli helps to handle peering connectons with MongoDB Atlas service.'
  spec.homepage      = 'https://github.com/jjuarez/atlas_peering_ctl'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'httparty', '0.16.2'
  spec.add_runtime_dependency 'json',     '2.1.0'
  spec.add_runtime_dependency 'thor',     '0.20.0'

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake',    '~> 10.0'
  spec.add_development_dependency 'rspec',   '~> 3.0'
  spec.add_development_dependency 'rubocop', '0.58.1'
end

