# -*- encoding: utf-8 -*-
require File.expand_path('../lib/markitdown/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Christopher Petersen"]
  gem.email         = ["christopher.petersen@gmail.com"]
  gem.description   = %q{A library that uses Nokogiri to parse HTML and produce Markdown}
  gem.summary       = %q{Converts HTML to Markdown}
  gem.homepage      = "https://github.com/cpetersen/markitdown"

  gem.add_dependency('nokogiri')
  gem.add_dependency('linguist')
  gem.add_development_dependency('rake')
  gem.add_development_dependency('rspec')
  gem.add_development_dependency('coveralls')

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "markitdown"
  gem.require_paths = ["lib"]
  gem.version       = Markitdown::VERSION
end
