$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "acts_as_pdf/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "acts_as_pdf"
  s.version     = '0.1.1'
  s.authors     = ["Oren Carta-Lag"]
  s.email       = ["oren.carta-lag@hotmail.fr"]
  s.homepage    = "http://rubygems.org/gems/acts_as_pdf"
  s.summary     = "A simple markdown to pdf gem"
  s.description = "Description of ActsAsPdf."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

end
