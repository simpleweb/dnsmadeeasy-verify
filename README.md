# dnsmadeeasy-verify

Gem to verify that domains on DNS Made Easy actually have their name servers set to DNS Made Easy.

```ruby
#Output domains not on DNS Made Easy

domains = Dnsmadeeasy_verify.domains_not_on_dnsmadeeasy
domains.each do |k,v|
  if not v.registered then
    puts k + " is not registered"
  else
    puts k + " does not have name servers correctly set"
  end
end
```
