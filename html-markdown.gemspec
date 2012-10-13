# -*- encoding: utf-8 -*-
require File.expand_path('../lib/html-markdown/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Christopher Petersen"]
  gem.email         = ["christopher.petersen@gmail.com"]
  gem.description   = %q{A small library that uses Nokogiri to parse an HTML file and produce Markdown}
  gem.summary       = %q{Converts HTML to Markdown}
  gem.homepage      = ""

  gem.add_dependency('nokogiri')
  gem.add_development_dependency('rake')
  gem.add_development_dependency('rspec')

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "html-markdown"
  gem.require_paths = ["lib"]
  gem.version       = Html::Markdown::VERSION
end
