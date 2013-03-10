# Middleman Google Analytics

Middleman-Google-Analytics is a [Middleman](https://github.com/middleman/middleman)
extension that generates Google Analytics tracking code, and keeps your config
in `config.rb`, where it belongs.

## Installation

If you already have a Middleman project:

Add `gem "middleman-google-analytics"` to your `Gemfile` then open up your `config.rb` and add:

```ruby
# Activate google-analytics extension
activate :google_analytics do |ga|
  ga.tracking_id = 'UA-XXXXXXX-X'
end
```

Then, in your layout, after your footer, call `google_analytics_tag` and
include the results in the page.  For example, in HAML:

```haml
= google_analytics_tag
```

Or ERB:

```erb
<%= google_analytics_tag %>
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

## License

Copyright (c) 2013 Jon Frisby

Licensed under the terms of the MIT X11 license.  See LICENSE.
