require 'dnsruby'

module Dnsmadeeasy_verify

  class Domain
    include Dnsruby

    attr_accessor :id, :name

    def initialize(id, name)
      @id = id
      @name = name
    end

    def available
      @whois ||= Whois.whois(@name)
      @whois.available?
    end

    def registered
      @whois ||= Whois.whois(@name)
      @whois.registered?
    end

    def do_name_servers_contain(domain)
      name_servers = get_name_servers
      return name_servers.any?{ |s| s.downcase().include?(domain) }
    end

    def get_name_servers
      ns = []
      res = Dnsruby::Resolver.new
      res.retry_times=(2)
      ns_req = nil
      begin
        ns_req = res.query(@name, "NS")
      rescue Exception => e
        return []
      end
      if (ns_req.header.ancount == 0)
        return []
      end

      ns_req = res.query(@name, "NS")
      (ns_req.answer.select {|r| r.type == "NS"}).each do |nsrr|
        ns << nsrr.domainname.to_s
      end

      ns
    end

  end

end
