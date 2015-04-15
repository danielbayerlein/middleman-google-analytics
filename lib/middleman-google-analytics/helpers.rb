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
        google_analytics_settings = app.config[:google_analytics_settings]

        return nil if app.development? && !google_analytics_settings.development

        @options = google_analytics_settings
        file = File.join(File.dirname(__FILE__), template)
        content = ERB.new(File.read(file)).result(binding)
        content = Uglifier.compile(content) if google_analytics_settings.minify
        content_tag(:script, content, type: 'text/javascript')
      end

    end
  end
end
