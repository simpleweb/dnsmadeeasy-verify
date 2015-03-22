require 'dnsruby'

module Dnsmadeeasy_verify

  class Domain
    include Dnsruby

    attr_accessor :name

    def initialize(name)
      @name = name
    end

    def available
      whois = Whois.whois(@name)
      whois.available?
    end

    def ns
      res = Dnsruby::Resolver.new
      res.retry_times=(2)
      ns_req = nil
      begin
        ns_req = res.query(@name, "NS")
      rescue Exception => e
        print "Error : #{e}"
        return
      end
      if (ns_req.header.ancount == 0)
        print "No nameservers found for #{@name}\n"
        return
      end

      ns_req = res.query(@name, "NS")
      (ns_req.answer.select {|r| r.type == "NS"}).each do |nsrr|
        puts nsrr.domainname
      end
    end

  end

end
