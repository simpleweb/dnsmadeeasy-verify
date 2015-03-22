require 'time'
require 'base64'
require 'cgi'
require 'openssl'

module Dnsmadeeasy_verify
  @base_uri = 'https://api.dnsmadeeasy.com'

  private
  def self.hmac_sha1(data, secret)
      hmac = OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('sha1'), secret.encode("ASCII"), data.encode("ASCII"))
  end

  private
  def self.get_auth_headers(api_key, api_secret)
    date_of_request = Time.now().httpdate

    headers = {
      'x-dnsme-apiKey' => api_key,
      'x-dnsme-requestDate' => date_of_request,
      'x-dnsme-hmac' => hmac_sha1(date_of_request,api_secret)
    }
  end

  def self.get_all_domains(api_key, api_secret)
      faraday = Faraday.new(:url => @base_uri)
      faraday.headers = get_auth_headers(api_key, api_secret)
      faraday.get '/V2.0/dns/managed/'
  end

end
