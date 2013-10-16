# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "middleman-google-analytics"
  s.version     = "0.0.2"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jon Frisby"]
  s.email       = ["jfrisby@mrjoy.com"]
  s.homepage    = "http://github.com/MrJoy/middleman-google-analytics"
  s.summary     = %q{A Middleman plugin for handling Google Analytics tracking code.}
  # s.description = %q{A longer description of your extension}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # The version of middleman-core your extension depends on
  s.add_runtime_dependency("middleman-core", [">= 3.0.6"])

  # Additional dependencies
  # s.add_runtime_dependency("gem-name", "gem-version")
end
