# -*- encoding: utf-8 -*-
require File.expand_path('../lib/presta_shop/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["iaintshine"]
  gem.email         = ["bodziomista@gmail.com"]
  gem.description   = %q{A library for Ruby to interact with the PrestaShop's Web Service API}
  gem.summary       = %q{A library for Ruby to interact with the PrestaShop's Web Service API}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "presta_shop"
  gem.require_paths = ["lib"]
  gem.version       = PrestaShop::VERSION
  gem.license       = "MIT"

  gem.add_dependency("rest-client", ">= 1.6.7")
  gem.add_dependency("nokogiri", ">= 1.5.9")
end
