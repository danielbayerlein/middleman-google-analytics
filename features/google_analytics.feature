Feature: Google Analytics tag helper

  Scenario: Basic tracking code
    Given the Server is running at "basic-app"
    When I go to "/google-analytics.html"
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
    Given the Server is running at "debug-app"
    When I go to "/google-analytics.html"
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
    Given the Server is running at "across-a-domain-app"
    When I go to "/google-analytics.html"
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
    Given the Server is running at "across-multiple-domains-app"
    When I go to "/google-analytics.html"
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
    Given the Server is running at "anonymize-ip-app"
    When I go to "/google-analytics.html"
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
    Given the Server is running at "disable-app"
    When I go to "/google-analytics.html"
    Then I should see "0" lines

  Scenario: Compress the JavaScript code
    Given the Server is running at "compress-js-app"
    When I go to "/google-analytics.html"
    Then I should see:
      """
      <script type="text/javascript">var _gaq=_gaq||[];_gaq.push(["_setAccount","UA-123456-78"]),_gaq.push(["_trackPageview"]),function(){var t=document.createElement("script");t.type="text/javascript",t.async=!0,t.src=("https:"==document.location.protocol?"//ssl":"//www")+".google-analytics.com/ga.js";var e=document.getElementsByTagName("script")[0];e.parentNode.insertBefore(t,e)}();</script>
      """

  Scenario: Full options
    Given the Server is running at "full-app"
    When I go to "/google-analytics.html"
    Then I should see:
      """
      <script type="text/javascript">var _gaq=_gaq||[];_gaq.push(["_setAccount","UA-123456-78"]),_gaq.push(["_setDomainName","example.com"]),_gaq.push(["_setAllowLinker",!0]),_gaq.push(["_gat._anonymizeIp"]),_gaq.push(["_trackPageview"]),function(){var e=document.createElement("script");e.type="text/javascript",e.async=!0,e.src=("https:"==document.location.protocol?"//ssl":"//www")+".google-analytics.com/u/ga_debug.js";var a=document.getElementsByTagName("script")[0];a.parentNode.insertBefore(e,a)}();</script>
      """
