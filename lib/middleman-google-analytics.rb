# Require core library
require "middleman-core"


# Register extensions which can be activated
# Make sure we have the version of Middleman we expect
::Middleman::Extensions.register(:google_analytics) do
  require 'middleman-google-analytics/extension'

  # Return the extension module
  ::Middleman::GoogleAnalytics
end
