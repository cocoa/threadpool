# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'threadpool/version'

Gem::Specification.new do |gem|
  gem.name          = "threadpool"
  gem.version       = Threadpool::VERSION
  gem.authors       = ["cocoa"]
  gem.email         = ["cocoa@scanpix.es"]
  gem.description   = %q{Thread Pool implementation in Ruby in order to limit the number of simultaneous running threads.}
  gem.summary       = %q{Use this code if you want to process multiple requests in parallel but not simultaneously.}
  gem.homepage      = "http://github.com/cocoa"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  # development dependency for testing with rspec
  gem.add_development_dependency "rspec"  

end
