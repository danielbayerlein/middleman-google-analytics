Feature: Google Analytics tag helper

  Scenario: Basic tracking code
    Given a fixture app "test-app"
    And a file named "config.rb" with:
      """
      activate :google_analytics do |ga|
        ga.tracking_id = 'UA-123456-78'
        ga.debug = false
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

  Scenario: Set domain name
    Given a fixture app "test-app"
    And a file named "config.rb" with:
      """
      activate :google_analytics do |ga|
        ga.tracking_id = 'UA-123456-78'
        ga.domain_name = 'example.com'
        ga.debug = false
        ga.allow_linker = false
        ga.anonymize_ip = false
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

  Scenario: Multiple top-level domains
    Given a fixture app "test-app"
    And a file named "config.rb" with:
      """
      activate :google_analytics do |ga|
        ga.tracking_id = 'UA-123456-78'
        ga.domain_name = 'example.com'
        ga.debug = false
        ga.allow_linker = true
        ga.anonymize_ip = false
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
        ga.domain_name = nil
        ga.debug = false
        ga.allow_linker = false
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
        _gaq.push(["_gat._anonymizeIp"]);
        _gaq.push(["_trackPageview"]);
        (function() {
          var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
          ga.src = ('https:' == document.location.protocol ? '//ssl' : '//www') + '.google-analytics.com/u/ga_debug.js';
          var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
        })();
      </script>
      """

