require 'erubis'
require 'uglifier'
require 'active_support/core_ext/string/indent'

module Middleman
  module GoogleAnalytics
    module Helpers

      def google_analytics_tag
        options = extensions[:google_analytics].options

        return nil if legacy_development? && !options.development

        file = File.join(File.dirname(__FILE__), 'analytics.js.erb')
        context = { options: options }
        content = Erubis::FastEruby.new(File.read(file)).evaluate(context)
        content = Uglifier.compile(content) if options.minify

        if options.output.to_sym == :html
          content = indent(content) unless options.minify
          content_tag(:script, content, type: 'text/javascript')
        else
          content
        end
      end

      # Ugly but true
      def indent(content)
        str = "\n"
        content.each_line { |line| str << line.indent(2) }
        str
      end

      # Support for Middleman >= 3.4
      def legacy_development?
        # Middleman 3.4
        is_development = try(:development?)
        unless is_development.nil?
          return is_development
        end

        # Middleman 4.x
        app.development?
      end

    end
  end
end
