Gem::Specification.new do |gem|
  gem.version            = File.read('VERSION').chomp
  gem.date               = File.mtime('VERSION').strftime('%Y-%m-%d')

  gem.name               = "borsh"
  gem.homepage           = "https://github.com/dryruby/borsh.rb"
  gem.license            = "Unlicense"
  gem.summary            = "Borsh for Ruby"
  gem.description        = "A Ruby library for the Borsh binary serialization format."
  gem.metadata           = {
    'bug_tracker_uri'   => "https://github.com/dryruby/borsh.rb/issues",
    'changelog_uri'     => "https://github.com/dryruby/borsh.rb/blob/master/CHANGES.md",
    'documentation_uri' => "https://github.com/dryruby/borsh.rb/blob/master/README.md",
    'homepage_uri'      => gem.homepage,
    'source_code_uri'   => "https://github.com/dryruby/borsh.rb",
  }

  gem.author             = "Arto Bendiken"
  gem.email              = "arto@bendiken.net"

  gem.platform           = Gem::Platform::RUBY
  gem.files              = %w(AUTHORS CHANGES.md README.md UNLICENSE VERSION) + Dir.glob('lib/**/*.rb')
  gem.bindir             = %q(bin)
  gem.executables        = %w()

  gem.required_ruby_version = '>= 2.6'  # macOS 12+
  gem.add_development_dependency 'rspec', '~> 3.12'
  gem.add_development_dependency 'yard' , '~> 0.9'
end
