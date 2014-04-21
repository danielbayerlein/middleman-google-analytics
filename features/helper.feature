Feature: Google Analytics tag helper

  Scenario: Basic tracking code
    Given a fixture app "test-app"
    And a file named "config.rb" with:
      """
      activate :google_analytics do |ga|
        ga.tracking_id = 'UA-123456-78'
      end
      """
      Given the Server is running at "test-app"
      When I go to "/"
      Then I should see:
      """
      <script type="text/javascript">
        var _gaq = _gaq || [];
        _gaq.push(["_setAccount", "UA-123456-78"]);
        _gaq.push(["_trackPageview"]);
        (function() {
          var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
          ga.src = ('https:' == document.location.protocol ? '//ssl' : '//www') + '.google-analytics.com/ga.js';
          var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
        })();
      </script>
      """

  Scenario: On debug mode
    Given a fixture app "test-app"
    And a file named "config.rb" with:
      """
      activate :google_analytics do |ga|
        ga.tracking_id = 'UA-123456-78'
        ga.debug = true
      end
      """
      Given the Server is running at "test-app"
      When I go to "/"
      Then I should see:
      """
      <script type="text/javascript">
        var _gaq = _gaq || [];
        _gaq.push(["_setAccount", "UA-123456-78"]);
        _gaq.push(["_trackPageview"]);
        (function() {
          var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
          ga.src = ('https:' == document.location.protocol ? '//ssl' : '//www') + '.google-analytics.com/u/ga_debug.js';
          var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
        })();
      </script>
      """

  Scenario: Tracking across a domain and its subdomains
    Given a fixture app "test-app"
    And a file named "config.rb" with:
      """
      activate :google_analytics do |ga|
        ga.tracking_id = 'UA-123456-78'
        ga.domain_name = 'example.com'
      end
      """
      Given the Server is running at "test-app"
      When I go to "/"
      Then I should see:
      """
      <script type="text/javascript">
        var _gaq = _gaq || [];
        _gaq.push(["_setAccount", "UA-123456-78"]);
        _gaq.push(["_setDomainName", "example.com"]);
        _gaq.push(["_trackPageview"]);
        (function() {
          var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
          ga.src = ('https:' == document.location.protocol ? '//ssl' : '//www') + '.google-analytics.com/ga.js';
          var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
        })();
      </script>
      """

  Scenario: Tracking across multiple domains and subdomains
    Given a fixture app "test-app"
    And a file named "config.rb" with:
      """
      activate :google_analytics do |ga|
        ga.tracking_id = 'UA-123456-78'
        ga.domain_name = 'example.com'
        ga.allow_linker = true
      end
      """
      Given the Server is running at "test-app"
      When I go to "/"
      Then I should see:
      """
      <script type="text/javascript">
        var _gaq = _gaq || [];
        _gaq.push(["_setAccount", "UA-123456-78"]);
        _gaq.push(["_setDomainName", "example.com"]);
        _gaq.push(["_setAllowLinker", true]);
        _gaq.push(["_trackPageview"]);
        (function() {
          var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
          ga.src = ('https:' == document.location.protocol ? '//ssl' : '//www') + '.google-analytics.com/ga.js';
          var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
        })();
      </script>
      """

  Scenario: Removing the last octet of the IP address
    Given a fixture app "test-app"
    And a file named "config.rb" with:
      """
      activate :google_analytics do |ga|
        ga.tracking_id = 'UA-123456-78'
        ga.anonymize_ip = true
      end
      """
      Given the Server is running at "test-app"
      When I go to "/"
      Then I should see:
      """
      <script type="text/javascript">
        var _gaq = _gaq || [];
        _gaq.push(["_setAccount", "UA-123456-78"]);
        _gaq.push(["_gat._anonymizeIp"]);
        _gaq.push(["_trackPageview"]);
        (function() {
          var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
          ga.src = ('https:' == document.location.protocol ? '//ssl' : '//www') + '.google-analytics.com/ga.js';
          var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
        })();
      </script>
      """

  Scenario: Disable tracking in development environment
    Given a fixture app "test-app"
    And a file named "config.rb" with:
      """
      activate :google_analytics do |ga|
        ga.tracking_id = 'UA-123456-78'
        ga.development = false
      end
      """
      Given the Server is running at "test-app"
      When I go to "/"
      Then I should see:
      """
      <script type="text/javascript">
        var _gaq = _gaq || [];
        _gaq.push(["_setAccount", "UA-123456-78"]);
        (function() {
          var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
          ga.src = ('https:' == document.location.protocol ? '//ssl' : '//www') + '.google-analytics.com/ga.js';
          var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
        })();
      </script>
      """

    Scenario: Compress the JavaScript code
      Given a fixture app "test-app"
      And a file named "config.rb" with:
        """
        activate :google_analytics do |ga|
          ga.tracking_id = 'UA-123456-78'
          ga.minify = true
        end
        """
        Given the Server is running at "test-app"
        When I go to "/"
        Then I should see:
        """
        <script type="text/javascript">var _gaq=_gaq||[];_gaq.push(["_setAccount","UA-123456-78"]),_gaq.push(["_trackPageview"]),function(){var t=document.createElement("script");t.type="text/javascript",t.async=!0,t.src=("https:"==document.location.protocol?"//ssl":"//www")+".google-analytics.com/ga.js";var e=document.getElementsByTagName("script")[0];e.parentNode.insertBefore(t,e)}();</script>
        """

  Scenario: Full options
    Given a fixture app "test-app"
    And a file named "config.rb" with:
      """
      activate :google_analytics do |ga|
        ga.tracking_id = 'UA-123456-78'
        ga.domain_name = 'example.com'
        ga.debug = true
        ga.allow_linker = true
        ga.anonymize_ip = true
        ga.development = true
        ga.minify = true
      end
      """
      Given the Server is running at "test-app"
      When I go to "/"
      Then I should see:
      """
      <script type="text/javascript">var _gaq=_gaq||[];_gaq.push(["_setAccount","UA-123456-78"]),_gaq.push(["_setDomainName","example.com"]),_gaq.push(["_setAllowLinker",!0]),_gaq.push(["_gat._anonymizeIp"]),_gaq.push(["_trackPageview"]),function(){var e=document.createElement("script");e.type="text/javascript",e.async=!0,e.src=("https:"==document.location.protocol?"//ssl":"//www")+".google-analytics.com/u/ga_debug.js";var a=document.getElementsByTagName("script")[0];a.parentNode.insertBefore(e,a)}();</script>
      """
