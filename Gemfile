source 'https://rubygems.org'

gem 'rails', '4.2.1'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'


# Gems used only for assets and not required
# in production environments by default.
group :assets, :production do
  gem 'less-rails'
  gem 'jquery-rails'
  gem 'fancybox-rails'
 
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'

  gem 'bootstrap-will_paginate'
  gem 'font-awesome-rails'
end

group :production, :staging do
  gem "newrelic_rpm"
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

# We use cancancan for authorization
gem 'cancancan'

# We want to use HAML syntax
gem 'haml-rails'

# We use paperclip to process our images
gem 'paperclip', '~> 3.0'
# We can also do videos
gem 'paperclip-ffmpeg'

# We have to put this outside
gem 'formtastic-bootstrap'

gem 'ui_datepicker-rails3'

# We store our images on S3
gem 'aws-sdk', '~> 1.5.7'

# We use Google analytics
gem 'google-analytics-rails'

# reading exif data
gem 'exifr'

# use postgresql
gem 'pg'

# use images loaded
gem 'imagesLoaded_rails'

# faster links
gem 'turbolinks'

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
