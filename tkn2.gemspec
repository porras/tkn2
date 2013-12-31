# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tkn2/version'

Gem::Specification.new do |spec|
  spec.name          = "tkn2"
  spec.version       = Tkn2::VERSION
  spec.authors       = ["Sergio Gil"]
  spec.email         = ["sgilperez@gmail.com"]
  spec.description   = %q{tkn2 is a terminal based presentation tool based on fxn's tkn}
  spec.summary       = %q{tkn2 is a terminal based presentation tool based on fxn's tkn}
  spec.homepage      = "https://github.com/porras/tkn2"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "pygments.rb"
  spec.add_dependency "thor"
  spec.add_dependency "bundler"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
