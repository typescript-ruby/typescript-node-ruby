# -*- encoding: utf-8 -*-
require File.expand_path('../lib/typescript-node/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'typescript-node'

  gem.authors       = ['KAWACHI Takashi']
  gem.email         = ['tkawachi@gmail.com']
  gem.description   = %q{TypeScript ruby interface using Node.js}
  gem.summary       = gem.description
  gem.homepage      = 'https://github.com/typescript-ruby/typescript-node-ruby'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.version       = TypeScript::Node::VERSION

  gem.add_dependency 'typescript-src', '~> 2.4.2'
  gem.add_development_dependency 'rake'

  gem.required_ruby_version = '>= 1.9.3'
end
