# Changelog

## 3.0.0 (2016-12-21)

* Remove the old GA implementation. The Universal Analytics tag is the new
  operating standard for the Google Analytics tracking tag.

  See: https://support.google.com/analytics/answer/2790010

  Rename `google_analytics_universal_tag` to `google_analytics_tag`.
* `debug`, `debug_trace` and `test` option added, see https://developers.google.com/analytics/devguides/collection/analyticsjs/debugging
* `disable` option added to disable the extension.
* Drop support for Ruby 2.1 and 2.0
* Coveralls added.

## 2.1.1 (2016-04-26)

* Incompatibility of uglifier with the latest version of Middleman fixed, see #26.

## 2.1.0 (2016-02-21)

* Support for Enhanced Link Attribution, see #25.

## 2.0.1 (2015-12-18)

* Patch for #legacy_development?, see #24.

## 2.0.0 (2015-12-16)

* Middleman v4 support added.
* Global google_analytics_settings removed.
* Output option added.
* Erubis instead of ERB.
* Require Ruby 2.0 or greater.
* Require Middleman 3.4 or greater.

## 1.1.0 (2015-01-06)

* Handling for development option revised, see #19.
* Refactoring Middleman::GoogleAnalytics.

## 1.0.2 (2014-06-05)

* Fix conflicting version of Uglifier (Middleman >= 3.2).

## 1.0.1 (2014-06-05) yanked

* Fix conflicting version of Uglifier (Middleman 3.2.2).

## 1.0.0 (2014-05-09)

* Refactoring Middleman::GoogleAnalytics.
* No longer compatible with Middleman < 3.2.
* Require Ruby 1.9.3 or greater.
* Development option for tracking in development environment.
* Minify option for compress the JavaScript code.

## 0.1.1 (2014-04-20)

* Fix Universal Analytics code.

## 0.1.0 (2014-04-16) yanked

* Add Universal Analytics support.

## 0.0.3 (2014-01-07)

* Add license info to gemspec.

## 0.0.2 (2013-10-16)

* Remove CDATA markerts that were choking some minifiers.
* Allow linking of sub-domains to their parent domain.
* Make URLs protocol-neutral so things work on both HTTP and HTTPS.
* (Optionally) use GA debug mode in preview server.
* Implement ability to anonymize IPs.
* Use asynchronous loading for GA JS.

## 0.0.1 (2013-03-10)

* Initial version
