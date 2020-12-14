# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
  config.infer_spec_type_from_file_location!

  config.include Devise::TestHelpers, type: :controller
  config.extend ControllerMacros, type: :controller

  config.include Rails.application.routes.url_helpers

  # for our heywatch mocking
  config.before(:each) do
    stub_request(:post, "https://api.coconut.co/v1/job").to_return(status: 201, body: '{"id": 9429,"errors": {},"output_urls": {"android_720p": "sftp://photasti.cc/videos_encoded/9/705/android.mp4","mp4_720p": "sftp://photasti.cc/videos_encoded/9/705/ios.mp4","jpg_250x250": ["sftp://photasti.cc/videos_encoded/9/705/thumb.jpg"],"flash_360p": "sftp://photasti.cc/system/videos_encoded/9/705/flash.flv"},"event": "job.completed"}', headers: {})
  end
end
