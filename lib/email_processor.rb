class EmailProcessor
  def initialize(email)
    @email = email
  end
  
  def create_article(tag_list)
    Article.create(title: @email.subject, body: @email.body, from: @email.from[:email].to_s, tag_list: tag_list)
  end  
  
  def process
    n=""
    acceptable_to = [ "errata-notices@freebsd.org", "announce@openbsd.org","freebsd-announce@freebsd.org", "netbsd-announce@netbsd.org", "security-advisories@freebsd.org","midnightbsd-security@midnightbsd.org", "security-announce@lists.pfsense.org"]
    to = @email.to.map {|a| a[:email].downcase}
    n= acceptable_to & to
    reddit_client = RedditKit::Client.new ENV["reddit_name"], ENV["reddit_pass"] 
    reddit_client.user_agent = "BSDSec.net"
    case n[0]
    when "announce@openbsd.org"
      a = create_article("openbsd")
      $client.update(@email.subject[0..100] + "... #OpenBSD https://bsdsec.net/articles/#{a.friendly_id}")
      reddit_client.submit(a.title[0..100] + "...","bsdsec",{url: "https://bsdsec.net/articles/#{a.friendly_id}"})
    when "freebsd-announce@freebsd.org"
      a = create_article("freebsd")
      $client.update(@email.subject[0..100] + "... #FreeBSD https://bsdsec.net/articles/#{a.friendly_id}")
      reddit_client.submit(a.title[0..100] + "...","bsdsec",{url: "https://bsdsec.net/articles/#{a.friendly_id}"})
    when "security-advisories@freebsd.org"
      a = create_article("freebsd")
      $client.update(@email.subject[0..100] + "... #FreeBSD https://bsdsec.net/articles/#{a.friendly_id}")
      reddit_client.submit(a.title[0..100] + "...","bsdsec",{url: "https://bsdsec.net/articles/#{a.friendly_id}"})
    when "errata-notices@freebsd.org"
      a = create_article("freebsd")
      $client.update(@email.subject[0..100] + "... #FreeBSD https://bsdsec.net/articles/#{a.friendly_id}")
      reddit_client.submit(a.title[0..100] + "...","bsdsec",{url: "https://bsdsec.net/articles/#{a.friendly_id}"})
    when "midnightbsd-security@midnightbsd.org"
      a =create_article("midnightbsd")
      $client.update(@email.subject[0..100] + "... #MidnightBSD https://bsdsec.net/articles/#{a.friendly_id}")
      reddit_client.submit(a.title[0..100] + "...","bsdsec",{url: "https://bsdsec.net/articles/#{a.friendly_id}"})      
    when "netbsd-announce@netbsd.org"
      a = create_article("netbsd")
      $client.update(@email.subject[0..100] + "... #NetBSD https://bsdsec.net/articles/#{a.friendly_id}")
      reddit_client.submit(a.title[0..100] + "...","bsdsec",{url: "https://bsdsec.net/articles/#{a.friendly_id}"})
    when "security-announce@lists.pfsense.org"
      a = create_article("pfsense")
      $client.update(@email.subject[0..100] + "... #pfSense https://bsdsec.net/articles/#{a.friendly_id}")
      reddit_client.submit(a.title[0..100] + "...","bsdsec",{url: "https://bsdsec.net/articles/#{a.friendly_id}"})
    else
      Email.create(from: @email.from[:email].to_s, to: @email.to.map {|a| a[:email].downcase}.to_s, cc: @email.cc.map {|a| a[:email].downcase}.to_s, subject: @email.subject, body: @email.body) #unless n[0]==nil
    end
  end	
end