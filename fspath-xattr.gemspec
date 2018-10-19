# encoding: UTF-8

Gem::Specification.new do |s|
  s.name        = 'fspath-xattr'
  s.version     = '1.0.3'
  s.summary     = %q{FSPath methods xattr and lxattr to work with extended attributes using ffi-xattr gem}
  s.homepage    = "http://github.com/toy/#{s.name}"
  s.authors     = ['Ivan Kuchin']
  s.license     = 'MIT'

  s.rubyforge_project = s.name

  s.metadata = {
    'bug_tracker_uri'   => "https://github.com/toy/#{s.name}/issues",
    'documentation_uri' => "https://www.rubydoc.info/gems/#{s.name}/#{s.version}",
    'source_code_uri'   => "https://github.com/toy/#{s.name}",
  }

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = %w[lib]

  s.add_dependency 'fspath', '>= 2', '< 4'
  s.add_dependency 'ffi-xattr', '>= 0.0.4', '< 0.2'
  s.add_development_dependency 'rspec', '~> 3.0'
end
