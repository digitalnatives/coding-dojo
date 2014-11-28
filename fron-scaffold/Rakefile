require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require 'quality_control'
require 'quality_control/all'
require 'fron'

Opal.paths << File.expand_path('../source/javascripts', __FILE__)

QualityControl::Rubycritic.directories += %w(source)
QualityControl::SCSS.directories += %w(source)
QualityControl::Yard.threshold = 95
QualityControl::OpalRspec.files = /^source\/.*\.rb/
QualityControl::OpalRspec.threshold = 95

QualityControl.tasks += %w(
  syntax:ruby
  syntax:scss
  opal:rspec
  documentation:coverage
  rubycritic:coverage
)

namespace :assets do
  task :precompile do
    sh 'middleman build'
  end
end
