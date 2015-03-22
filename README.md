# dnsmadeeasy-verify

Gem to verify that domains on DNS Made Easy actually have their name servers set to DNS Made Easy.

```ruby
#Output domains not on DNS Made Easy

domains = Dnsmadeeasy_verify.domains_not_on_dnsmadeeasy
domains.each do |k,v|
  puts k
end
```
