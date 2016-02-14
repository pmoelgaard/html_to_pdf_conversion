# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'html_to_pdf_conversion/version'

Gem::Specification.new do |spec|
  spec.name          = "html_to_pdf_conversion"
  spec.version       = PDFlayer::VERSION
  spec.authors       = ["Peter Andreas Moelgaard"]
  spec.email         = ["github@petermolgaard.com"]

  spec.summary       = "html_to_pdf_conversion"
  spec.description   = "html_to_pdf_conversion"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "httparty"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "dotenv"

end
