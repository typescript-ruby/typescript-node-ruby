#!/usr/bin/env rake
require 'bundler/gem_tasks'
require 'rake/testtask'

desc 'download the latest TypeScript source files'
task 'typescript:download' do
  sh 'npm', 'install', '-g', 'typescript'
end

desc 'upgrade TypeScript source files'
task 'typescript:upgrade' => %i(typescript:download) do
  mv 'node_modules/typescript', 'lib/support'
end

Rake::TestTask.new do |test|
  test.libs << "test"
  test.test_files = FileList['test/test*.rb']
  test.verbose = true
end

task :default => :test
