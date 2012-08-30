# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rspec/sitemap/matchers/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Attila Györffy"]
  gem.email         = ["attila.gyorffy@unboxedconsulting.com"]
  gem.description   = %q{Sitemaps for RSpec}
  gem.summary       = %q{Sitemap protocol matchers for RSpec}
  gem.homepage      = "http://github.com/unboxed/rspec-sitemap-matchers"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "rspec-sitemap-matchers"
  gem.require_paths = ["lib"]
  gem.version       = RSpec::Sitemap::Matchers::VERSION

  gem.add_runtime_dependency('rspec')
  gem.add_runtime_dependency('nokogiri')
  gem.add_runtime_dependency('debugger')

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'guard-rspec'
end
