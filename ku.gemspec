require File.expand_path('../lib/ku/version', __FILE__)

Gem::Specification.new do |s|
  s.authors       = ["Lamont Granquist"]
  s.email         = ["lamont@scriptkiddie.org"]
  s.description   = %q{Kerbal Updater}
  s.summary       = s.description
  s.homepage      = "https://github.com/lamont-granquist/ku"
  s.license       = "Apache 2.0"

  s.files         = `git ls-files`.split($\)
  s.executables   = Array.new
  s.test_files    = s.files.grep(%r{^(spec)/})
  s.name          = "ku"
  s.require_paths = ["lib"]
  s.version       = Ku::VERSION
  s.required_ruby_version = ">= 2.2.0"

  #s.add_dependency 'varia_model',             '~> 0.4.0'
end
