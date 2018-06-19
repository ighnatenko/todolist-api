source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.4.2'

gem 'rails', '~> 5.2.0'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'active_model_serializers', '~> 0.10.7'
gem 'devise', '~> 4.4', '>= 4.4.1'
gem 'devise_token_auth', '~> 0.1.43'
gem 'rack-cors', require: 'rack/cors'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem "figaro"
gem 'cancancan', '~> 2.1', '>= 2.1.3'
gem 'carrierwave', '~> 1.0'
gem 'file_validators'

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
end

group :development, :test do
  gem 'database_cleaner', '~> 1.6', '>= 1.6.2'
  gem 'factory_bot_rails', '~> 4.8', '>= 4.8.2'
  gem 'ffaker', '~> 2.8', '>= 2.8.1'
  gem 'pry', '~> 0.11.3'
  gem 'rspec-rails', '~> 3.7', '>= 3.7.2'
  gem 'shoulda-matchers', '~> 3.1', '>= 3.1.2'
end