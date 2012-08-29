# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rspec-sitemap-matchers/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Attila Györffy"]
  gem.email         = ["attila.gyorffy@unboxedconsulting.com"]
  gem.description   = %q{RSpec for Sitemaps}
  gem.summary       = %q{RSpec matchers for the Sitemap protocol}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "rspec-sitemap-matchers"
  gem.require_paths = ["lib"]
  gem.version       = Rspec::Sitemap::Matchers::VERSION
end
