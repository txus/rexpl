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
  s.summary     = %q{Rexpl is an interactive bytecode REPL for Rubinius}
  s.description = %q{Rexpl is an interactive bytecode REPL for Rubinius}

  s.rubyforge_project = "rexpl"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end