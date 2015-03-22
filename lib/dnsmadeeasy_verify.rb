require 'faraday'
require 'whois'
require 'json'
require 'dnsruby'
require 'dnsmadeeasy_verify/Domain'
require 'dnsmadeeasy_verify/Dnsmadeeasy_api'

module Dnsmadeeasy_verify

  def self.list_domains
    domains = Hash.new
    response = get_all_domains(Dnsmadeeasy_verify.configuration.dnsmadeeasy_api_key, Dnsmadeeasy_verify.configuration.dnsmadeeasy_api_secret)
    case response.status
      when 200
        data = JSON.parse(response.body)

        data['data'].each do |child|
            domains[child["name"]] = Domain.new(child["name"])
        end

    end

    domains
  end

  def self.domains_not_on_dnsmadeeasy()
    domains = self.list_domains

    domains.each do |k, v|
      # If none of the name server are set to dnsmadeeasy
      if not v.ns.any?{ |s| s.downcase().include?("dnsmadeeasy.com") }
        if v.registered
          puts k + " does not have name servers set to dnsmadeeasy"
        else
          puts k + " is not registered"
        end
      end
    end

  end

  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||=  Configuration.new
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :dnsmadeeasy_api_key
    attr_accessor :dnsmadeeasy_api_secret

    def initialize
      @dnsmadeeasy_api_key = ''
      @dnsmadeeasy_api_secret = ''
    end
  end

end
