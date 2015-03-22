
module Dnsmadeeasy_verify

  class Domain
    attr_accessor :name

    def initialize(name)
      @name = name
    end

    def available
      whois = Whois.whois(@name)
      whois.available
    end

  end

end
