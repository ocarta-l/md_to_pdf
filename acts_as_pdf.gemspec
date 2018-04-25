$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'acts_as_pdf/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'acts_as_pdf'
  s.version     = ActsAsPdf::VERSION
  s.authors     = ['Oren Carta-Lag']
  s.email       = ['oren.carta-lag@hotmail.fr']
  s.homepage    = 'http://rubygems.org/gems/acts_as_pdf'
  s.summary     = 'A simple markdown to pdf gem.'
  s.description = 'A simple markdown to pdf gem.'
  s.license     = 'MIT'

  s.add_dependency 'html-pipeline', '~> 2.7.0'
  s.add_dependency 'prawn_rails'
  s.add_dependency 'wicked_pdf'
  s.add_dependency 'wkhtmltopdf-binary'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
end
