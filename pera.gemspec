# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pera/version'

Gem::Specification.new do |gem|
  gem.name          = "pera"
  gem.version       = Pera::VERSION
  gem.authors       = ["Akihiro Matsumura"]
  gem.email         = ["mat_aki@sonicgarden.jp"]
  gem.description   = %q{Pera connect Rails and Cordova. Pera is framework to create mobile application very simple.}
  gem.summary       = %q{Simple Mobile App Framework for Rails}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_dependency 'activesupport', ['>= 3.2.8']
end
