Feature: Google Analytics tag helper

  Scenario: Basic tracking code
    Given the Server is running at "basic-app"
    When I go to "/google-analytics.html"
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
    Given the Server is running at "across-a-domain-app"
    When I go to "/google-analytics.html"
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
    Given the Server is running at "across-multiple-domains-app"
    When I go to "/google-analytics.html"
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
    Given the Server is running at "anonymize-ip-app"
    When I go to "/google-analytics.html"
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
    Given the Server is running at "disable-app"
    When I go to "/google-analytics.html"
    Then I should see "0" lines

  Scenario: Compress the JavaScript code
    Given the Server is running at "compress-js-app"
    When I go to "/google-analytics.html"
    Then I should see:
      """
      <script type="text/javascript">!function(e,a,t,n,c,o,s){e.GoogleAnalyticsObject=c,e[c]=e[c]||function(){(e[c].q=e[c].q||[]).push(arguments)},e[c].l=1*new Date,o=a.createElement(t),s=a.getElementsByTagName(t)[0],o.async=1,o.src=n,s.parentNode.insertBefore(o,s)}(window,document,"script","//www.google-analytics.com/analytics.js","ga"),ga("create","UA-123456-78","auto"),ga("send","pageview");</script>
      """

  Scenario: Enhanced Link Attribution
    Given the Server is running at "enhanced-link-attribution-app"
    When I go to "/google-analytics.html"
    Then I should see:
      """
      <script type="text/javascript">
        (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
        (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
        m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
        })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
        ga('create', 'UA-123456-78', 'auto');
        ga('require', 'linkid');
        ga('send', 'pageview');
      </script>
      """

  Scenario: Full options
    Given the Server is running at "full-app"
    When I go to "/google-analytics.html"
    Then I should see:
      """
      <script type="text/javascript">!function(e,a,n,t,c,i,o){e.GoogleAnalyticsObject=c,e[c]=e[c]||function(){(e[c].q=e[c].q||[]).push(arguments)},e[c].l=1*new Date,i=a.createElement(n),o=a.getElementsByTagName(n)[0],i.async=1,i.src=t,o.parentNode.insertBefore(i,o)}(window,document,"script","//www.google-analytics.com/analytics.js","ga"),ga("create","UA-123456-78","example.com",{allowLinker:!0}),ga("set","anonymizeIp",!0),ga("require","linkid"),ga("send","pageview");</script>
      """

  Scenario: JavaScript output style
    Given the Server is running at "output-app"
    When I go to "/javascripts/google_analytics.js"
    Then I should see:
      """
      (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
      (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
      m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
      })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
      ga('create', 'UA-123456-78', 'auto');
      ga('send', 'pageview');
      """

  Scenario: Build HTML with default configuration
    Given a fixture app "basic-app"
    And a successfully built app at "basic-app"
    When I cd to "build"
    Then the file "google-analytics.html" should contain:
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
