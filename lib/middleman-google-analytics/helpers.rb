require 'erubis'
require 'uglifier'

module Middleman
  module GoogleAnalytics
    module Helpers

      def google_analytics_tag
        render_script('analytics.js.erb')
      end

      def google_analytics_universal_tag
        render_script('analytics_universal.js.erb')
      end

      private

      def render_script(template)
        options = extensions[:google_analytics].options

        return nil if app.development? && !options.development

        file = File.join(File.dirname(__FILE__), template)
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

    end
  end
end
