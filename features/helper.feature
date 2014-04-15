Feature: Google Analytics tag helper

  Scenario: Basic legacy tracking code
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
          ga.src = ('https:' == document.location.protocol ? '//ssl' : '//www') + '.google-analytics.com/u/ga_debug.js';
          var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
        })();
      </script>
      """

