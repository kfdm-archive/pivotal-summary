require 'rubygems'
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "pivotal-summary"
  gem.homepage = "http://github.com/kfdm/pivotal-summary"
  gem.license = "MIT"
  gem.summary = "Print out summaries of your tickets from Pivotal Tracker"
  gem.description = "Print out summaries of your tickets from Pivotal Tracker"
  #gem.email = "kungfudiscomonkey@gmail.com"
  gem.authors = ["Paul Traylor"]
  # Include your dependencies below. Runtime dependencies are required when using your gem,
  # and development dependencies are only needed for development (ie running rake tasks, tests, etc)
  #  gem.add_runtime_dependency 'jabber4r', '> 0.1'
  #  gem.add_development_dependency 'rspec', '> 1.2.3'
  gem.add_runtime_dependency "colored"
  gem.add_runtime_dependency "pivotal-tracker"
  gem.add_development_dependency "jeweler", "~> 1.5.2"
end
Jeweler::RubygemsDotOrgTasks.new

task :default => :test
