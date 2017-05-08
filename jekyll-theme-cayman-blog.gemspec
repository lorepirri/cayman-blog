# encoding: utf-8

Gem::Specification.new do |s|
  s.name          = "jekyll-theme-cayman-blog"
  s.version       = "0.0.5"
  s.license       = "CC0-1.0"
  s.authors       = ["Lorenzo Pirritano"]
  s.email         = ["lorepirri@gmail.com"]
  s.homepage      = "https://github.com/lorepirri/cayman-blog"
  s.summary       = "Cayman Blog is a Jekyll theme for GitHub Pages. Based on Cayman theme, with blogging features."

  s.files         = `git ls-files -z`.split("\x0").select do |f|
    f.match(%r{^((_includes|_layouts|_sass|assets)/|(LICENSE|README|index|about|contact)((\.(txt|md|markdown)|$)))}i)
  end

  s.platform      = Gem::Platform::RUBY
  s.add_runtime_dependency "jekyll", "~> 3.3"
end
