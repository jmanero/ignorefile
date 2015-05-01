# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'ignorefile/version'

Gem::Specification.new do |spec|
  spec.name = 'ignorefile'
  spec.version = IgnoreFile::VERSION
  spec.authors = ['John Manero']
  spec.email = ['john.manero@gmail.com']
  spec.summary = 'Compile a set of ignore statements from files and code'
  spec.description = IO.read(File.expand_path('../README.md', __FILE__)) rescue ''
  spec.homepage = 'https://github.com/jmanero/ignorefile'
  spec.license = 'MIT'

  spec.files = `git ls-files`.split("\n")
  spec.executables = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'thor-scmversion', '1.7.0'
end
