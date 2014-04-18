require 'middleman-core'
require 'middleman-google-analytics/version'

::Middleman::Extensions.register(:google_analytics) do
  require 'middleman-google-analytics/extension'
  ::Middleman::GoogleAnalyticsExtension
end
