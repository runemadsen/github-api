# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "github-api"
  s.version     = "0.0.1"
  s.authors     = ["Rune Madsen"]
  s.email       = ["rune@runemadsen.com"]
  s.homepage    = ""
  s.summary     = %q{A simple gem to simplify requests to the Github API}
  s.description = %q{A simple gem to simplify requests to the Github API}

  s.rubyforge_project = "github-api"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "json"
  s.add_development_dependency "rspec", "~> 2.6"
  s.add_dependency "httparty"
end
