lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cert_check/version'

Gem::Specification.new do |spec|
  spec.name          = 'cert-check'
  spec.version       = CertCheck::VERSION
  spec.authors       = ['ryoma123']
  spec.email         = ['ryoma.ono.2661@gmail.com']
  spec.summary       = 'CLI tool for check the certificate files and return information.'
  spec.description   = 'CLI tool for check the certificate files and return information.'
  spec.homepage      = 'https://github.com/ryoma123/cert-check'
  spec.license       = 'MIT'

  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'thor', '~> 0.20.3'
  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.63.1'
end
