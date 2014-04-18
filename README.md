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
    ga.tracking_id = 'UA-XXXXXXX-X'
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

## Configuration

```ruby
activate :google_analytics do |ga|
  ga.tracking_id = 'UA-XXXXXXX-X' # Property ID
  ga.debug = false # Manually set debug flag (if true, links to /u/ga_debug.js)
  ga.anonymize_ip = true # Removing the last octet of the IP address
  ga.domain_name = 'example.com' # Track for (cross-domain tracking)
  ga.allow_linker = true # Multiple top-level domains (needs domain_name to be set)
end
```

## Only Including Tracking Code in Builds

To include the tracking code only in builds, and not when running
`middleman server`, simply add environment-specific configurations in your
`config.rb`:

```ruby
configure :development do
  activate :google_analytics do |ga|
    ga.tracking_id = false
  end
end

configure :build do
  activate :google_analytics do |ga|
    ga.tracking_id = 'UA-XXXXXXX-X'
  end
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

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new [Pull Request](../../pull/new/master)

## License

Copyright (c) 2014 Daniel Bayerlein. See [LICENSE](./LICENSE) for details.

Copyright (c) 2013 Jon Frisby.
