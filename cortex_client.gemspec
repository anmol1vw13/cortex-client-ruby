lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cortex_client/version'

Gem::Specification.new do |spec|
  spec.name          = 'anmol_2_cortex_client_ruby'
  spec.version       = CortexClient::VERSION
  spec.authors       = ['Anmol Vijaywargiya', 'Bhumika Goyal']
  spec.email         = ['anmol.vijaywargiya@gojek.com', 'bhumika.goyal@gojek.com']

  spec.summary       = 'Client to push resource to cortex'
  spec.description   = ''
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop-airbnb', '1.0.0'
  spec.add_runtime_dependency 'google-protobuf', '3.11.4'
  spec.add_development_dependency 'webmock', '~> 3'
  spec.add_runtime_dependency 'snappy_ext', '0.1.2'
  spec.add_runtime_dependency 'http', '~> 4.1'
end
