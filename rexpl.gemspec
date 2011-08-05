# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rexpl/version"

Gem::Specification.new do |s|
  s.name        = "rexpl"
  s.version     = Rexpl::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Josep M. Bach"]
  s.email       = ["josep.m.bach@gmail.com"]
  s.homepage    = "http://github.com/txus/rexpl"
  s.summary     = %q{Rexpl is an interactive bytecode console for Rubinius}
  s.description = %q{Rexpl is an interactive bytecode console for Rubinius}

  s.rubyforge_project = "rexpl"

  s.add_runtime_dependency "ansi"
  s.add_development_dependency "minitest"
  s.add_development_dependency "mocha"
  s.add_development_dependency 'yard'
  s.add_development_dependency 'bluecloth'
  s.add_development_dependency "purdytest"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
