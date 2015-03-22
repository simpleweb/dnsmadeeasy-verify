Gem::Specification.new do |s|
  s.name        = 'dnsmadeeasy_verify'
  s.version     = '0.0.1'
  s.date        = '2015-03-22'
  s.summary     = "DNS Made Easy is a name server provider. This gem verifys domains match."
  s.description = "Uses DNS Made Easy as the domain source list to ns lookup name servers and verify."
  s.authors     = ["Tom Holder"]
  s.email       = 'tom@simpleweb.co.uk'
  s.files       = Dir["{lib}/**/*", "Gemfile"]
  s.homepage    =
    'http://rubygems.org/gems/cheetahmail'
  s.license       = 'MIT'
  s.add_dependency "faraday",["~> 0.9.1"]
  s.add_dependency "whois",["~> 3.5.8"]
  s.add_dependency "dnsruby",["~> 1.57.0"]
end
