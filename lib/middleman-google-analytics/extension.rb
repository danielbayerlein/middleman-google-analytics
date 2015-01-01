require 'middleman-google-analytics/helpers'

module Middleman
  class GoogleAnalyticsExtension < Extension
    option :tracking_id, nil, 'Property ID'
    option :anonymize_ip, false, 'Removing the last octet of the IP address'
    option :domain_name, nil, 'Tracking across a domain and its subdomains'
    option :allow_linker, false, 'Tracking across multiple domains and ' \
                                 'subdomains'
    option :debug, false, 'Tracking Code Debugger'
    option :development, true, 'Tracking in development environment'
    option :minify, false, 'Compress the JavaScript code'

    def initialize(app, options_hash={}, &block)
      super

      app.set :google_analytics_settings, options
    end

    def after_configuration
      unless options.tracking_id
        $stderr.puts 'Google Analytics: Please specify a property ID'
        raise 'No property ID given' if display?
      end

      if options.allow_linker and not options.domain_name
        $stderr.puts 'Google Analytics: Please specify a domain_name when ' \
                     'using allow_linker'
        raise 'No domain_name given' if display?
      end
    end

    helpers do
      include ::Middleman::GoogleAnalytics::Helpers
    end

    private

    def display?
      app.build? || app.development? && options.development
    end

  end
end
