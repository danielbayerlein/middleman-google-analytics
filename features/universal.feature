Feature: Google Analytics universal tag helper

  Scenario: Basic tracking code
    Given a fixture app "test-app-universal"
    And a file named "config.rb" with:
      """
      activate :google_analytics do |ga|
        ga.tracking_id = 'UA-123456-78'
      end
      """
      Given the Server is running at "test-app-universal"
      When I go to "/"
      Then I should see:
      """
      <script type="text/javascript">
        (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
        (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
        m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
        })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
        ga('create', 'UA-123456-78', 'auto');
        ga('send', 'pageview');
      </script>
      """

  Scenario: Tracking across a domain and its subdomains
    Given a fixture app "test-app-universal"
    And a file named "config.rb" with:
      """
      activate :google_analytics do |ga|
        ga.tracking_id = 'UA-123456-78'
        ga.domain_name = 'example.com'
      end
      """
      Given the Server is running at "test-app-universal"
      When I go to "/"
      Then I should see:
      """
      <script type="text/javascript">
        (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
        (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
        m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
        })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
        ga('create', 'UA-123456-78', 'example.com');
        ga('send', 'pageview');
      </script>
      """

  Scenario: Tracking across multiple domains and subdomains
    Given a fixture app "test-app-universal"
    And a file named "config.rb" with:
      """
      activate :google_analytics do |ga|
        ga.tracking_id = 'UA-123456-78'
        ga.domain_name = 'example.com'
        ga.allow_linker = true
      end
      """
      Given the Server is running at "test-app-universal"
      When I go to "/"
      Then I should see:
      """
      <script type="text/javascript">
        (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
        (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
        m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
        })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
        ga('create', 'UA-123456-78', 'example.com', {'allowLinker': true});
        ga('send', 'pageview');
      </script>
      """

  Scenario: Removing the last octet of the IP address
    Given a fixture app "test-app-universal"
    And a file named "config.rb" with:
      """
      activate :google_analytics do |ga|
        ga.tracking_id = 'UA-123456-78'
        ga.anonymize_ip = true
      end
      """
      Given the Server is running at "test-app-universal"
      When I go to "/"
      Then I should see:
      """
      <script type="text/javascript">
        (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
        (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
        m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
        })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
        ga('create', 'UA-123456-78', 'auto');
        ga('set', 'anonymizeIp', true);
        ga('send', 'pageview');
      </script>
      """

    Scenario: Disable tracking in development environment
      Given a fixture app "test-app-universal"
      And a file named "config.rb" with:
        """
        activate :google_analytics do |ga|
          ga.tracking_id = 'UA-123456-78'
          ga.development = false
        end
        """
        Given the Server is running at "test-app-universal"
        When I go to "/"
        Then I should see:
        """
        <script type="text/javascript">
          (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
          (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
          m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
          })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
          ga('create', 'UA-123456-78', 'auto');
        </script>
        """

    Scenario: Compress the JavaScript code
      Given a fixture app "test-app-universal"
      And a file named "config.rb" with:
        """
        activate :google_analytics do |ga|
          ga.tracking_id = 'UA-123456-78'
          ga.minify = true
        end
        """
        Given the Server is running at "test-app-universal"
        When I go to "/"
        Then I should see:
        """
        <script type="text/javascript">!function(e,a,t,n,c,o,s){e.GoogleAnalyticsObject=c,e[c]=e[c]||function(){(e[c].q=e[c].q||[]).push(arguments)},e[c].l=1*new Date,o=a.createElement(t),s=a.getElementsByTagName(t)[0],o.async=1,o.src=n,s.parentNode.insertBefore(o,s)}(window,document,"script","//www.google-analytics.com/analytics.js","ga"),ga("create","UA-123456-78","auto"),ga("send","pageview");</script>
        """

  Scenario: Full options
    Given a fixture app "test-app-universal"
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
      Given the Server is running at "test-app-universal"
      When I go to "/"
      Then I should see:
      """
      <script type="text/javascript">!function(e,a,n,t,c,o,s){e.GoogleAnalyticsObject=c,e[c]=e[c]||function(){(e[c].q=e[c].q||[]).push(arguments)},e[c].l=1*new Date,o=a.createElement(n),s=a.getElementsByTagName(n)[0],o.async=1,o.src=t,s.parentNode.insertBefore(o,s)}(window,document,"script","//www.google-analytics.com/analytics.js","ga"),ga("create","UA-123456-78","example.com",{allowLinker:!0}),ga("set","anonymizeIp",!0),ga("send","pageview");</script>
      """
