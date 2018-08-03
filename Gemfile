source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails', '~> 5.1.6'
gem 'puma', '~> 3.7'
# del ↓
# gem 'sass-rails', '~> 5.0'
# del ↑
gem 'uglifier', '>= 1.3.0'
# gem 'therubyracer', platforms: :ruby
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'

gem 'bootstrap-sass', '~> 3.3.7'
gem 'sass-rails', '>= 3.2'
gem 'devise'
gem 'toastr-rails'
gem 'omniauth-facebook'
gem 'thin'
#エラーが発生するので、versionを5.3.0に修正
gem "paperclip", "~> 6.0.0"
# gem "paperclip", "~> 5.3.0"
# gem 'aws-sdk', '~> 2.3'
gem 'aws-sdk', '~> 3'
#gem 'aws-sdk-s3' エラー発生
gem 'dropzonejs-rails'
gem "figaro", "~>1.1.0"
gem "geocoder"
gem "jquery-ui-rails"
#stripeに接続する際、エラー「Unable to connect to Stripe. uninitialized constant StripeOauth::RestClie」が発生するため、追記
gem 'rest-client'
#↑
gem 'stripe'

group :development, :test do
  gem 'sqlite3'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
