# middleman-google-analytics

[![Gem Version](https://badge.fury.io/rb/middleman-google-analytics.svg)](http://badge.fury.io/rb/middleman-google-analytics)
[![Build Status](https://travis-ci.org/danielbayerlein/middleman-google-analytics.svg?branch=master)](https://travis-ci.org/danielbayerlein/middleman-google-analytics)
[![Dependency Status](https://gemnasium.com/danielbayerlein/middleman-google-analytics.svg)](https://gemnasium.com/danielbayerlein/middleman-google-analytics)

**middleman-google-analytics** is a [Middleman](http://middlemanapp.com)
extension that generates
[Google Analytics](https://www.google.de/intl/en/analytics/) tracking code, and
keeps your config in `config.rb`, where it belongs.

## Installation

1. Specify the dependency in your project's `Gemfile`:

  ```ruby
  # Gemfile
  gem "middleman-google-analytics"
  ```

2. Activate the Google Analytics extension in your project's `config.rb`:

  ```ruby
  # config.rb
  activate :google_analytics do |ga|
    ga.tracking_id = 'UA-XXXXXXX-X' # Replace with your property ID.
  end
  ```

3. In your layout, after your footer, call `google_analytics_tag` or
   `google_analytics_universal_tag` and include the results in the page:

  **Haml:**

  ```haml
  # Google Analytics
  = google_analytics_tag
  ```

  ```haml
  # Universal Analytics
  = google_analytics_universal_tag
  ```

  **ERB:**

  ```erb
  # Google Analytics
  <%= google_analytics_tag %>
  ```

  ```erb
  # Universal Analytics
  <%= google_analytics_universal_tag %>
  ```
  
  NOTE: [The Universal Analytics tag is the new operating standard for the Google Analytics tracking tag.][1]
  
  [1]: https://support.google.com/tagmanager/answer/6107124?hl=en

## Configuration

```ruby
activate :google_analytics do |ga|
  # Property ID (default = nil)
  ga.tracking_id = 'UA-XXXXXXX-X'

  # Removing the last octet of the IP address (default = false)
  ga.anonymize_ip = false

  # Tracking across a domain and its subdomains (default = nil)
  ga.domain_name = 'example.com'

  # Tracking across multiple domains and subdomains (default = false)
  ga.allow_linker = false

  # Tracking Code Debugger (default = false)
  ga.debug = false

  # Tracking in development environment (default = true)
  ga.development = true

  # Compress the JavaScript code (default = false)
  ga.minify = false
end
```

## Usage

Once you've bundled you should be able to run middleman as normal, and have it
display the GA tracking code.

## Special Thanks

* [Jon Frisby (@MrJoy)](https://github.com/MrJoy)
  * For the initial code.
* [Atsushi Nagase (@ngs)](https://github.com/ngs)
  * Cucumber tests and "Universal Analytics" support.
* [Contributors](../../graphs/contributors)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new [Pull Request](../../pull/new/master)

## License

Copyright (c) 2014-2015 Daniel Bayerlein. See [LICENSE](./LICENSE) for details.

Copyright (c) 2013 Jon Frisby.
