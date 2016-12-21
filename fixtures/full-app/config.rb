activate :google_analytics do |ga|
  ga.tracking_id = 'UA-123456-78'
  ga.domain_name = 'example.com'
  ga.allow_linker = true
  ga.enhanced_link_attribution = true
  ga.anonymize_ip = true
  ga.minify = true
  ga.output = :html
end
