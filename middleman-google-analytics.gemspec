# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'middleman-google-analytics/version'

Gem::Specification.new do |s|
  s.name = 'middleman-google-analytics'
  s.version = Middleman::GoogleAnalytics::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ['Daniel Bayerlein', 'Jon Frisby']
  s.email = ['daniel.bayerlein@googlemail.com', 'jfrisby@mrjoy.com']
  s.homepage = 'https://github.com/danielbayerlein/middleman-google-analytics'
  s.summary = 'A Middleman plugin for handling Google Analytics tracking code.'
  s.description = 'middleman-google-analytics is a Middleman extension that generates Google Analytics tracking code, and keeps your config in config.rb, where it belongs.'
  s.license = 'MIT'

  s.files = `git ls-files`.split('\n')
  s.test_files = `git ls-files -- {test,spec,features}/*`.split('\n')
  s.executables = `git ls-files -- bin/*`.split('\n').map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.required_ruby_version = '>= 1.9.3'
  s.add_dependency('middleman-core', ['>= 4.0.0.beta.1'])
  s.add_dependency('uglifier', ['~> 2.6'])
  s.add_dependency('erubis')
end
