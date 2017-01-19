$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'automatic_record/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'automatic_record'
  s.version     = AutomaticRecord::VERSION
  s.authors     = ['Greg Woods']
  s.email       = ['greg@westlakeinteractive.com']
  s.homepage    = 'https://github.com/westlakedesign/automatic_record'
  s.summary     = 'Automatically create has_one and belongs_to associations the first time they are fetched'
  s.description = 'Automatically create a has_one or belongs_to association the first time it is accessed. Also supports optional default attributes or block usage to customize the record creation.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['spec/**/*'].reject { |f| f.match(/^spec\/dummy\/(log|tmp)/) }

  s.add_dependency 'rails'

  s.add_development_dependency 'mysql2'
  s.add_development_dependency 'rspec-rails', '~> 3.1.0'
  s.add_development_dependency 'factory_girl_rails', '~> 4.4.1'
  s.add_development_dependency 'database_cleaner', '~> 1.3.0'
  s.add_development_dependency 'simplecov', '~> 0.7.1'
  s.add_development_dependency 'rubocop'
end
