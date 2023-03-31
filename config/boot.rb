ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

require 'rack/server'
module Rails
  class Server < ::Rack::Server
    def default_options
      super.merge({
        :Port => 3030
      })
    end
  end
end
