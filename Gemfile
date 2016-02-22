source 'https://rubygems.org'
ruby '2.2.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.13'

# Use postgresql as the database for Active Record
gem 'pg'

gem 'sorcery'
gem 'kaminari'
gem 'remotipart'
gem 'jquery-rails'
gem 'coffee-rails', '~> 4.0.0'
gem 'rabl'
gem 'yajl-ruby', require: 'yajl'
gem 'i18n-js'
gem 'libxml-ruby'
gem 'turbolinks'
gem 'jquery-turbolinks'
gem 'jbuilder', '~> 1.2'
gem 'mail-iso-2022-jp'
gem 'paranoia', "~> 2.0.0"
gem 'acts_as_list'


gem 'less-rails'
gem 'therubyracer'
gem 'execjs'
#gem 'twitter-bootstrap-rails'
gem 'twitter-bootstrap-rails', github: 'seyhunak/twitter-bootstrap-rails', branch: 'bootstrap3'
gem 'simple_form'

gem 'datetimepicker-rails', github: 'zpaulovics/datetimepicker-rails', branch: 'master', submodules: true
gem 'momentjs-rails', '~> 2.9',  :github => 'derekprior/momentjs-rails'


# 設定ファイルの一元化用
gem 'settingslogic'

gem 'sass-rails', '~> 4.0.0'
group :assets do
  gem 'uglifier', '>= 1.3.0'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
end

group :development do
  gem 'quiet_assets'
  gem 'thin'

  gem 'i18n_generators'

  gem 'capistrano', '=2.15.5'
  gem 'capistrano_colors'

  gem 'rails-footnotes'
  gem 'bullet'

end

group :production, :sample, :private_sample do
  gem 'daemons'
  gem 'rails_12factor'
end

