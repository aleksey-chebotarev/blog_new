source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'devise'
gem 'haml-rails'
gem 'jwt'
gem 'ffaker'
gem 'active_model_serializers'
gem 'kaminari'
gem 'simple_form'
gem 'carrierwave'
gem 'file_validators'
gem 'mini_magick'
gem 'bootstrap-sass'
gem 'jquery-rails'
gem 'aws-sdk-s3'
gem 'fog-aws'
# Background processing + web interface for sidekiq
gem 'sidekiq', '~> 4.2', '>= 4.2.10'
gem 'sidekiq-status'
gem 'sidekiq-failures'
gem 'sidekiq-unique-jobs'
gem 'sinatra', require: false
gem 'redis-namespace', '~> 1.5', '>= 1.5.3'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'selenium-webdriver'
  gem 'dotenv-rails', require: 'dotenv/rails-now'
  gem 'factory_girl_rails'
  gem 'pry-rails'
  gem 'letter_opener'
  gem 'simplecov'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'rails-controller-testing'
  gem 'database_cleaner'
  gem 'capybara'
  gem 'capybara-screenshot'
  gem 'capybara-webkit'
  gem 'rspec-sidekiq'
  gem 'email_spec'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
