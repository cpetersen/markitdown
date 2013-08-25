# -*- encoding: utf-8 -*-
require File.expand_path('../lib/markitdown/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "markitdown"
  gem.version       = Markitdown::VERSION
  gem.authors       = ["Christopher Petersen"]
  gem.email         = ["chris@petersen.io"]
  gem.description   = %q{A library that uses Nokogiri to parse HTML and produce Markdown}
  gem.summary       = %q{Converts HTML to Markdown}
  gem.homepage      = "https://github.com/cpetersen/markitdown"
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency('nokogiri')
  gem.add_development_dependency('rake')
  gem.add_development_dependency('rspec')
  gem.add_development_dependency('coveralls')
end
