source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails', '~> 5.1.1'
  gem 'pg'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'excon'

gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'pry'
gem 'will_paginate'
gem 'bootstrap-will_paginate'
gem 'paperclip', '~> 4.1.1'
gem 'factory_bot_rails'
gem 'database_cleaner'
gem 'bootstrap-sass'
gem 'bcrypt'
gem 'dry-monads'
# gem 'spotify-client'
#, git: "https://github.com/icoretech/spotify-client", ref: '91e8c3c89e67a9669e283ffa83ce49946d7f8ca3'


gem "react-rails"
source "https://rails-assets.org" do
  gem 'rails-assets-react-date-picker'
  gem "rails-assets-moment"
end

gem 'react-bootstrap-rails'
gem 'classnames-rails'
gem 'axios_rails'

gem 'rest-client', '~> 1.7'
gem 'rspotify'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'sqlite3'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'rspec-rails'
  gem 'rails-controller-testing'
  gem 'faker'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

ruby "2.7.6"