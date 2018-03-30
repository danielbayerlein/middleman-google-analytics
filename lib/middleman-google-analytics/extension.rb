require 'middleman-google-analytics/helpers'

module Middleman
  class GoogleAnalyticsExtension < Extension

    option :tracking_id, nil, 'Property ID'
    option :anonymize_ip, false, 'Removing the last octet of the IP address'
    option :domain_name, nil, 'Tracking across a domain and its subdomains'
    option :allow_linker, false, 'Tracking across multiple domains and subdomains'
    option :enhanced_link_attribution, false, 'Enhanced Link Attribution'
    option :disable, false, 'Disable extension'
    option :debug, false, 'Log detail messages to the console'
    option :debug_trace, false, 'Trace debugging will output more verbose information to the console'
    option :test, false, 'Testing your implementation without sending hits'
    option :minify, false, 'Compress the JavaScript code'
    option :output, :html, 'Output style - :html includes <script> tag'

    def after_configuration
      options.test = true if ENV['TEST'] != 'true' && app.development?

      unless options.tracking_id
        $stderr.puts 'Google Analytics: Please specify a property ID'
        raise ArgumentError, 'No property ID given' if app.build?
      end

      if options.allow_linker and not options.domain_name
        $stderr.puts 'Google Analytics: Please specify a domain_name when using allow_linker'
        raise ArgumentError, 'No domain_name given' if app.build?
      end

      unless [:html, :js].include?(options.output.try(:to_sym))
        $stderr.puts 'Google Analytics: Please specify a valid output type (html|js).'
        raise ArgumentError, 'Only "html" or "js" allowed' if app.build?
      end
    end

    helpers do
      include ::Middleman::GoogleAnalytics::Helpers
    end

  end
end
