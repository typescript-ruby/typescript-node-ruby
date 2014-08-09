# Typescript::Node [![Build Status](https://secure.travis-ci.org/typescript-ruby/typescript-node-ruby.png?branch=master)](https://travis-ci.org/typescript-ruby/typescript-node-ruby)

TypeScript compiler in a gem.

## Installation

Add this line to your application's Gemfile:

    gem 'typescript-node'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install typescript-node

## Usage

```ruby
require 'typescript-node'

# raises an error if node(1) isn't available
TypeScript::Node.check_node

# compiles a TypeScript source file and returns TypeScript::Node::CompileResult
result = TypeScript::Node.compile_file(file, '--target', 'ES5')
result.success? # => true if succeeded
result.js # => output JavaScript source code
result.stdout # => what tsc(1) shows to stdout
result.stderr # => what tsc(1) shows to stderr

# compiles a TypeScript source code string and returns String
js_source = TypeScript::Node.compile_file(ts_source, '--target', 'ES5')
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
