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

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.required_ruby_version = '>= 2.3.0'
  s.add_dependency('middleman-core', ['>= 3.4'])
  # Middleman 3.4.1 requires "uglifier ~> 2.5"
  # Middleman 4.1.7 requires "uglifier ~> 3.0"
  s.add_dependency('uglifier', ['>= 2.5', '< 4.0'])
  s.add_dependency('activesupport', ['>= 4.1', '< 5.1'])
  s.add_dependency('erubis')
end
