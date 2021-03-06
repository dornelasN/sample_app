source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails',        '>= 5.1.2'
# bcrypt hashes password to prevent attackers to get the real passwords
gem 'bcrypt',       '>= 3.1.11'
# Faker makes sample users with semi-realistic names and email addresses
gem 'faker',        '>= 1.7.3'
# CarrierWave uploads an image and associate with the Micropost model
gem 'carrierwave',  '>= 1.1.0'
# mini_magick for image resizing
gem 'mini_magick',  '>= 4.7.0'
# fog: image upload in production 
gem 'fog',          '>= 1.40.0'
# will_paginate paginates users so that only an X amount of users show in our page
gem 'will_paginate', '>= 3.1.5'
# bootstrap-will_paginate configures will_paginate to use Bootstrap's pagination styles
gem 'bootstrap-will_paginate', '>= 1.0.0'
# Use Puma as the app server
gem 'puma',         '>= 3.9.1'
# Use Twitter Bootstrap for responsive design
gem 'bootstrap-sass', '>= 3.3.7'
# Use SCSS for stylesheets
gem 'sass-rails',   '>= 5.0.6'
# Use Gravatar to include profile images
gem 'gravatar', '>= 1.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier',     '>= 3.2.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '>= 4.2.2'
gem 'jquery-rails', '>= 4.3.1'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks',   '>= 5.0.1'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder',     '>= 2.7.0'

group :development, :test do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3', '>= 1.3.13'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug',  '>= 9.0.6', platform: :mri
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console',           '>= 3.5.1'
  gem 'listen',                '>= 3.0.8'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring',                '>= 2.0.2'
  gem 'spring-watcher-listen', '>= 2.0.1'
end

group :test do
  gem 'rails-controller-testing', '>= 1.0.2'
  gem 'minitest-reporters',       '>= 1.1.14'
  # Automate test runs with Guard
  gem 'guard',                    '>= 2.13.0'
  gem 'guard-minitest',           '>= 2.4.4'
end

group :production do
  gem 'pg', '>= 0.18.4'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]