module Middleman
  module GoogleAnalytics
    class Options < Struct.new(:tracking_id, :anonymize_ip, :allow_linker, :domain_name, :debug); end

    class << self
      def options
        @@options ||= Options.new
      end

      def registered(app, options={})
        @@options ||= Options.new(*options.values_at(*Options.members))
        yield @@options if block_given?

        unless @@options.tracking_id
           $stderr.puts 'Google Analytics: Please specify a property ID'
           raise 'No property ID given'
        end

        if @@options.allow_linker and not @@options.domain_name
          $stderr.puts 'Google Analytics: Please specify a domain_name when using allow_linker'
          raise 'No domain_name given'
        end

        app.send :include, InstanceMethods
      end
      alias :included :registered
    end

    module InstanceMethods
      def google_analytics_tag
        @options = ::Middleman::GoogleAnalytics.options
        javascript_tag(content('ga.js.erb'))
      end

      def google_analytics_universal_tag
        @options = ::Middleman::GoogleAnalytics.options
        javascript_tag(content('analytics.js.erb'))
      end

      private

      def content(filename)
        file = File.join(File.dirname(__FILE__), filename)
        ERB.new(File.read(file)).result(binding)
      end
      def javascript_tag(content)
        content_tag(:script, content, type: 'text/javascript')
      end
    end
  end
end
