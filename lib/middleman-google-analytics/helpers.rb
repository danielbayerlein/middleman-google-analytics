require 'uglifier'

module Middleman
  module GoogleAnalytics
    module Helpers

      def google_analytics_tag
        render_script('ga.js.erb')
      end

      def google_analytics_universal_tag
        render_script('analytics.js.erb')
      end

      private

      def render_script(template)
        options = extensions[:google_analytics].options

        return nil if app.development? && !options.development

        file = File.join(File.dirname(__FILE__), template)
        content = ERB.new(File.read(file)).result(binding)
        content = Uglifier.compile(content) if options.minify
        content_tag(:script, content, type: 'text/javascript')
      end

    end
  end
end
