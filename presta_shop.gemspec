# -*- encoding: utf-8 -*-
require File.expand_path('../lib/presta_shop/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["iaintshine"]
  gem.email         = ["bodziomista@gmail.com"]
  gem.description   = %q{A library for Ruby to interact with the PrestaShop's Web Service API}
  gem.summary       = %q{A library for Ruby to interact with the PrestaShop's Web Service API}
  gem.homepage      = "TODO: create a homepage"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "presta_shop"
  gem.require_paths = ["lib"]
  gem.version       = PrestaShop::VERSION
  gem.license       = "MIT"

  gem.add_dependency("rest-client", ">= 1.6.7")
  gem.add_dependency("nokogiri", ">= 1.5.9")
  gem.add_dependency("thor", ">= 0.14.4")

  gem.add_development_dependency("rspec", ">= 2.13.0")
  gem.add_development_dependency("fakeweb", "~> 1.3")
end
