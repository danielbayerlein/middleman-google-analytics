module Middleman
  class GoogleAnalyticsExtension < Extension
    option :tracking_id, nil, 'Property ID'
    option :anonymize_ip, false, 'Removing the last octet of the IP address'
    option :domain_name, nil, 'Tracking across a domain and its subdomains'
    option :allow_linker, false, 'Tracking across multiple domains and ' \
                                 'subdomains'
    option :debug, false, 'Tracking Code Debugger'
    option :development, true, 'Tracking in development environment'

    def initialize(app, options_hash={}, &block)
      super

      app.set :google_analytics_settings, options
    end

    def after_configuration
      unless options.tracking_id
        $stderr.puts 'Google Analytics: Please specify a property ID'
        raise 'No property ID given'
      end

      if options.allow_linker and not options.domain_name
        $stderr.puts 'Google Analytics: Please specify a domain_name when ' \
                     'using allow_linker'
        raise 'No domain_name given'
      end
    end

    helpers do
      def google_analytics_tag
        @options = google_analytics_settings
        file = File.join(File.dirname(__FILE__), 'ga.js.erb')
        content = ERB.new(File.read(file)).result(binding)
        content_tag(:script, content, type: 'text/javascript')
      end

      def google_analytics_universal_tag
        @options = google_analytics_settings
        file = File.join(File.dirname(__FILE__), 'analytics.js.erb')
        content = ERB.new(File.read(file)).result(binding)
        content_tag(:script, content, type: 'text/javascript')
      end
    end
  end
end
