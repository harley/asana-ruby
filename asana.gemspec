# -*- encoding: utf-8 -*-
require File.expand_path('../lib/asana/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Harley Trung"]
  gem.email         = ["harley@socialsci.com"]
  gem.description   = %q{Ruby wrapper for Asana}
  gem.summary       = %q{Ruby wrapper for Asana}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "asana"
  gem.require_paths = ["lib"]
  gem.version       = Asana::VERSION

  gem.add_development_dependency 'rspec', '~> 2.11'
  gem.add_development_dependency 'guard'
  gem.add_development_dependency 'guard-rspec'
end
