# -*- encoding: utf-8 -*-
require File.expand_path('../lib/lbank/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Laurynas Butkus']
  gem.email         = ['laurynas.butkus@gmail.com']
  gem.description   = %q{lbank.lt currency rates fetcher and converter}
  gem.summary       = %q{Fetches currency rates from Lithuanian Central Bank website. Does currency conversion. Supports historic currency rates.}
  gem.homepage      = 'https://github.com/laurynas/lbank'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'lbank'
  gem.require_paths = ['lib']
  gem.version       = Lbank::VERSION

  gem.add_dependency 'faraday'
  gem.add_dependency 'faraday_middleware'
  gem.add_dependency 'activesupport'
  gem.add_dependency 'multi_xml'

  gem.add_development_dependency 'rspec', '~> 3.5'
  gem.add_development_dependency 'rspec-its', '~> 1.2'
end
