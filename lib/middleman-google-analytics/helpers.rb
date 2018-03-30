require 'erubis'
require 'uglifier'
require 'active_support/core_ext/string/indent'

module Middleman
  module GoogleAnalytics
    module Helpers

      def google_analytics_tag
        options = extensions[:google_analytics].options

        return nil if options.disable

        file = File.join(File.dirname(__FILE__), 'analytics.js.erb')
        context = { options: options }
        content = Erubis::FastEruby.new(File.read(file)).evaluate(context)
        content = Uglifier.compile(content) if options.minify

        if options.output.to_sym == :html
          content = indent(content) unless options.minify
          content_tag(:script, content)
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

    end
  end
end
