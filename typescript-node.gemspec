# -*- encoding: utf-8 -*-
require File.expand_path('../lib/typescript-node/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["KAWACHI Takashi"]
  gem.email         = ["tkawachi@gmail.com"]
  gem.description   = %q{TypeScript ruby interface using Node.js}
  gem.summary       = %q{TypeScript ruby interface using Node.js}
  gem.homepage      = "https://github.com/tkawachi/typescript-node-ruby"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "typescript-node"
  gem.require_paths = ["lib"]
  gem.version       = TypeScript::Node::VERSION

  gem.add_dependency 'typescript-src', '0.8.1.1'
end
