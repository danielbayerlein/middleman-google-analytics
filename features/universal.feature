Feature: Google Analytics universal tag helper

  Scenario: Basic tracking code
    Given a fixture app "test-app-universal"
    And a file named "config.rb" with:
      """
      activate :google_analytics do |ga|
        ga.tracking_id = 'UA-123456-78'
        ga.domain_name = nil
        ga.debug = false
        ga.allow_linker = false
        ga.anonymize_ip = false
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

  Scenario: Set domain name
    Given a fixture app "test-app-universal"
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

  Scenario: Multiple top-level domains
    Given a fixture app "test-app-universal"
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
        ga.domain_name = nil
        ga.debug = false
        ga.allow_linker = false
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
        ga('set', 'anonymizeIp', true);
        ga('send', 'pageview');
      </script>
      """
