Gem::Specification.new do |s|
  s.name        = 'fintual'
  s.version     = '0.1.0'
  s.summary     = 'client for fintual.cl'
  s.description = 'A simple api client for fintual.cl'
  s.authors     = ['Alfredo Enrione']
  s.email       = 'aenrione@protonmail.com'
  s.homepage    =
    'https://rubygems.org/gems/fintual'
  s.license = 'MIT'
  s.required_ruby_version = Gem::Requirement.new('>= 2.3.0')
  s.add_dependency 'http'
  s.add_dependency 'json'
  s.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  s.bindir        = 'exe'
  s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ['lib']
end
