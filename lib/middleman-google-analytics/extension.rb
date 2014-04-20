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
        options = ::Middleman::GoogleAnalytics.options
        options.debug = development? if options.debug.nil?
        ga = options.debug ? 'u/ga_debug' : 'ga'
        domain_name = options.domain_name
        if tracking_id = options.tracking_id
          gaq = []
          gaq << ['_setAccount', "#{tracking_id}"]
          gaq << ['_setDomainName', "#{domain_name}"] if domain_name
          gaq << ['_setAllowLinker', true] if options.allow_linker
          gaq << ['_gat._anonymizeIp'] if options.anonymize_ip
          gaq << ['_trackPageview']
          %Q{<script type="text/javascript">
  var _gaq = _gaq || [];
  #{gaq.map! { |x| "_gaq.push(#{x});" }.join("\n  ")}
  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? '//ssl' : '//www') + '.google-analytics.com/#{ga}.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();
</script>}
        end
      end

      def google_analytics_universal_tag
        options = ::Middleman::GoogleAnalytics.options
        options.debug = development? if options.debug.nil?
        ga = options.debug ? 'u/ga_debug' : 'ga'
        domain_name = options.domain_name
        if tracking_id = options.tracking_id
          %Q{<script type="text/javascript">
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
  ga('create', '#{ tracking_id }', '#{ domain_name || 'auto' }'#{ options.allow_linker ? ", {'allowLinker': true}" : '' });#{
    options.anonymize_ip ? "\n  ga('set', 'anonymizeIp', true);" : '' }
  ga('send', 'pageview');
</script>}
        end
      end
    end
  end
end
