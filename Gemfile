source 'https://rubygems.org'

gem 'rails', '3.2.13'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'less-rails'
  gem 'jquery-rails'
  gem 'twitter-bootstrap-rails'
  gem 'formtastic-bootstrap'
  gem 'fancybox-rails'
 
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

group :production, :staging do
  gem "pg"
end

group :development do
  gem 'sextant'
end

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails', '~> 2.0'
  gem 'shoulda-matchers'
  gem 'factory_girl_rails'
  gem 'faker'
end

# We are using devise to authenticate with the app
gem 'devise'

# We use cancan for authorization
gem 'cancan'

# We want to use HAML syntax
gem 'haml-rails'

# We use paperclip to process our images
gem 'paperclip', '~> 3.0'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
