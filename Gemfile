source 'https://rubygems.org'
ruby '2.3.1'

gem 'rails', '4.2.0' # insecure
gem 'puma'
gem 'foreman' # foreman start starts the app, bundle here to make explicit dependency

# assets
gem 'sprockets', '<= 2.11.0'
gem 'sprockets-rails', '2.2.2'
gem 'sass-rails', git: 'git://github.com/edwardreed/sass-rails.git', branch: 'backport' # why backport?
gem 'uglifier', '>= 1.3.0' # Use Uglifier as compressor for JavaScript assets
gem 'coffee-rails', '~> 4.1.0' # Use CoffeeScript for .coffee assets and views (awww)
gem 'jquery-rails'
gem 'turbolinks' # see github/rails/turbolinks
gem 'jquery-turbolinks'
gem 'jbuilder', '~> 2.3'# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder, do we use this?
gem 'bootstrap-sass'
gem 'react-rails', '~> 1.0'
gem 'rails-backbone'


gem 'devise', '~> 3.4.1'

gem 'paperclip', '~> 4.2'
gem 'fog' # local images

gem 'masonry-rails', '~> 0.2.0'

gem 'acts-as-taggable-on', '~> 3.4'

gem 'area'

gem 'merit'

gem 'mailboxer'

gem 'public_activity'

gem 'pusher'

gem 'json-jwt'

gem 'httparty'

gem 'whenever', require: false # use activejob

gem 'elasticsearch-model'
gem 'elasticsearch-rails'

gem 'dotenv-rails' # .env file...

group :development do
  gem 'spring' # keeps app running in bg, see github/rails/spring
  gem 'spring-commands-rspec' # rspec binstub
  gem 'listen'
  gem 'spring-watcher-listen'
end

group :development, :test do
  gem 'sqlite3' # change this to pg for dev/prod parity
  gem 'pry-byebug' # An IRB alternative and runtime developer console.
  gem 'better_errors' # Better error page for Rack apps.
  gem 'binding_of_caller'
  gem 'faker'
  gem 'rspec-rails', '~> 3.5'
  gem 'factory_girl_rails'
end

group :test do
  gem 'capybara'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'database_cleaner'
  gem 'webmock'
end

group :production do
  gem 'pg'
  gem 'rails_12factor' # heroku requirement
  gem 'aws-sdk', '~> 1.5.7' # deprecated
end
