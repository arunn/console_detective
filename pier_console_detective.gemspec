require_relative 'lib/pier_console_detective/version'

Gem::Specification.new do |spec|
  spec.name          = "pier_console_detective"
  spec.version       = ConsoleDetective::VERSION
  spec.authors       = ["ArunkumarN"]
  spec.email         = ["arunn@arunn.dev"]
  spec.licenses      = ["MIT"]

  spec.summary       = %q{Track rails console user activity in real time}
  spec.description   = %q{Commands typed in rails console will be tracked realtime in a log file in the given format}
  spec.homepage      = "https://github.com/arunn/pier_console_detective"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/arunn/pier_console_detective"
  spec.metadata["changelog_uri"] = "https://github.com/arunn/pier_console_detective/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
