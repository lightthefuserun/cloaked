# frozen_string_literal: true

source 'https://rubygems.org'
gemspec name: 'cloaked'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem 'activerecord', '~> 6.0.0'

group :development do
  gem 'launchy', '~> 2.3'
  gem 'pry'
  gem 'pry-byebug'
end

group :test do
  gem 'rspec'
  gem 'rspec-mocks'
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rspec'
  gem 'simplecov', require: false
end
