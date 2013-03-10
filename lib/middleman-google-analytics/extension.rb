module Middleman
  module GoogleAnalytics
    class Options < Struct.new(:tracking_id); end

    class << self
      def options
        @@options ||= {}
      end

      def registered(app, options={})
        @@options ||= Options.new(options)
        yield @@options if block_given?

        app.send :include, InstanceMethods
      end
      alias :included :registered
    end

    module InstanceMethods
      def google_analytics_tag
        tracking_id = ::Middleman::GoogleAnalytics.options.tracking_id
        if(tracking_id)
          return %Q{<script type="text/javascript">
//<![CDATA[
  var _gaq=[['_setAccount','#{tracking_id}'],['_trackPageview']];
  (function(d,t){var g=d.createElement(t),s=d.getElementsByTagName(t)[0];
  g.src=('https:'==location.protocol?'//ssl':'//www')+'.google-analytics.com/ga.js';
  s.parentNode.insertBefore(g,s)}(document,'script'));
//]]>
</script>}
        end
      end
    end
  end
end
