require 'faraday'
require 'whois'
require 'json'
require 'dnsruby'
require 'dnsmadeeasy_verify/domain'
require 'dnsmadeeasy_verify/dnsmadeeasy_api'

module Dnsmadeeasy_verify

  # Returns all domains from DNS Made Easy
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

  # Returns all domains that are not correctly setup on DNS Made Easy
  def self.domains_not_on_dnsmadeeasy()
    domains = self.list_domains
    domains_not_on_dnsmadeeasy = Hash.new
    domains.each do |k, v|
      domains_not_on_dnsmadeeasy[k] = v unless v.do_name_servers_contain("dnsmadeeasy.com")
    end
    domains_not_on_dnsmadeeasy
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
