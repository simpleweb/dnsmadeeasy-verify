lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dnsmadeeasy_verify/version'

Gem::Specification.new do |s|
  s.name        = 'dnsmadeeasy_verify'
  s.version     = Dnsmadeeasy_verify::VERSION
  s.date        = '2015-03-22'
  s.summary     = "DNS Made Easy is a name server provider. This gem verifys domains match."
  s.description = "Uses DNS Made Easy as the domain source list to ns lookup name servers and verify."
  s.authors     = ["Tom Holder"]
  s.email       = 'tom@simpleweb.co.uk'
  s.files       = Dir["{lib}/**/*", "Gemfile"]
  s.require_paths = ["lib"]
  s.homepage    =
    'https://github.com/simpleweb/dnsmadeeasy-verify'
  s.license       = 'MIT'
  s.add_dependency "faraday",["~> 0.9.1"]
  s.add_dependency "whois",["~> 3.5.8"]
  s.add_dependency "dnsruby",["~> 1.57.0"]
end
