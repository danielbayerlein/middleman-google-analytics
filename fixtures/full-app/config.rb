activate :google_analytics do |ga|
  ga.tracking_id = 'UA-123456-78'
  ga.domain_name = 'example.com'
  ga.debug = true
  ga.allow_linker = true
  ga.anonymize_ip = true
  ga.development = true
  ga.minify = true
end
