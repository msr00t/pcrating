source 'https://rubygems.org'
ruby '2.2.2'

# Core
gem 'rails', '4.2.2'
gem 'pg'
gem 'pry-rails'

# CSS
gem 'sass-rails', '~> 5.0'
gem 'bootstrap-sass'

# JS
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc

# Functionality
gem 'devise'
gem 'will_paginate'
gem 'acts_as_votable', '~> 0.10.0'
gem 'ransack'
gem 'metamagic'
gem 'friendly_id', '~> 5.1.0'

group :test do
  gem 'capybara', '~> 2.2.1'
  gem 'factory_girl_rails', '~> 4.4.1'
  gem 'faker', '~> 1.3.0'
  gem 'database_cleaner', '~> 1.3.0'
  gem 'selenium-webdriver', '~> 2.42.0'
  gem 'poltergeist', '~> 1.5.1'
  gem 'fuubar'
  gem 'webmock', '~> 1.19.0'
  gem 'vcr'
  gem 'shoulda-matchers', require: false
end

group :development, :test do
  gem 'rspec-rails', '~> 3.0'
  gem 'rubocop'
  gem 'byebug'
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'letter_opener'
end

group :production do
  gem 'rails_12factor'
end
