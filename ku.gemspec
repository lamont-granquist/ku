require File.expand_path("../lib/ku/version", __FILE__)

Gem::Specification.new do |s|
  s.authors       = ["Lamont Granquist"]
  s.email         = ["lamont@scriptkiddie.org"]
  s.description   = "Kerbal Updater"
  s.summary       = s.description
  s.homepage      = "https://github.com/lamont-granquist/ku"
  s.license       = "Apache 2.0"

  s.files         = `git ls-files`.split($OUTPUT_RECORD_SEPARATOR)
  s.executables   = %w{ku}
  s.test_files    = s.files.grep(%r{^(spec)/})
  s.name          = "ku"
  s.require_paths = ["lib"]
  s.version       = Ku::VERSION
  s.required_ruby_version = ">= 2.2.0"

  s.add_dependency "thor"
  s.add_dependency "rspec"
end
