module Middleman
  module GoogleAnalytics
    class Options < Struct.new(:tracking_id, :anonymize_ip, :debug); end

    class << self
      def options
        @@options ||= Options.new(options)
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
        options = ::Middleman::GoogleAnalytics.options
        options.debug ||= (not build?)
        ga = options.debug ? 'ga' : '/u/ga_debug'
        if tracking_id = options.tracking_id
          gaq = []
          gaq << ['_setAccount', "#{tracking_id}"]
          gaq << ['_gat._anonymizeIp'] if options.anonymize_ip
          gaq << ['_trackPageview']
          %Q{<script type="text/javascript">
//<![CDATA[
  var _gaq = _gaq || [];
  #{gaq.map! { |x| "_gaq.push(#{x});" }.join("\n  ")}
  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? '//ssl' : '//www') + '.google-analytics.com/#{ga}.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();
//]]>
</script>}
        end
      end
    end
  end
end
