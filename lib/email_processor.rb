class EmailProcessor
  def self.process(email)
    n=""
    acceptable_to = ["announce@openbsd.org","freebsd-announce@freebsd.org", "netbsd-announce@netbsd.org", "security-advisories@freebsd.org", "security-announce@lists.pfsense.org"]
    to = email.to.each {|a| a.downcase!}
    n= acceptable_to & to
    reddit_client = RedditKit::Client.new ENV["reddit_name"], ENV["reddit_pass"] 
    reddit_client.user_agent = "BSDSec.net"
    case n[0]
    when "announce@openbsd.org"
      a = Article.create(title: email.subject, body: email.body, from: email.from.to_s, tag_list: "openbsd")
      $client.update(email.subject[0..100] + "... #OpenBSD http://bsdsec.net/articles/#{a.friendly_id}")
      reddit_client.submit(a.title[0..100] + "...","bsdsec",{url: "http://bsdsec.net/articles/#{a.friendly_id}"})
    when "freebsd-announce@freebsd.org" || "security-advisories@freebsd.org"
      b = Article.create(title: email.subject, body: email.body, from: email.from.to_s, tag_list: "freebsd")
      $client.update(email.subject[0..100] + "... #FreeBSD http://bsdsec.net/articles/#{b.friendly_id}")
      reddit_client.submit(b.title[0..100] + "...","bsdsec",{url: "http://bsdsec.net/articles/#{b.friendly_id}"})
    when "security-advisories@freebsd.org"
      b = Article.create(title: email.subject, body: email.body, from: email.from.to_s, tag_list: "freebsd")
      $client.update(email.subject[0..100] + "... #FreeBSD http://bsdsec.net/articles/#{b.friendly_id}")
      reddit_client.submit(b.title[0..100] + "...","bsdsec",{url: "http://bsdsec.net/articles/#{b.friendly_id}"})
    when "midnightbsd-security@midnightbsd.org"
      b = Article.create(title: email.subject, body: email.body, from: email.from.to_s, tag_list: "midnightbsd")
      $client.update(email.subject[0..100] + "... #MidnightBSD http://bsdsec.net/articles/#{b.friendly_id}")
      reddit_client.submit(b.title[0..100] + "...","bsdsec",{url: "http://bsdsec.net/articles/#{b.friendly_id}"})      
    when "netbsd-announce@netbsd.org"
      c = Article.create(title: email.subject, body: email.body, from: email.from.to_s, tag_list: "netbsd")
      $client.update(email.subject[0..100] + "... #NetBSD http://bsdsec.net/articles/#{c.friendly_id}")
      reddit_client.submit(c.title[0..100] + "...","bsdsec",{url: "http://bsdsec.net/articles/#{c.friendly_id}"})
    when "security-announce@lists.pfsense.org"
      c = Article.create(title: email.subject, body: email.body, from: email.from.to_s, tag_list: "pfsense")
      $client.update(email.subject[0..100] + "... #pfSense http://bsdsec.net/articles/#{c.friendly_id}")
      reddit_client.submit(c.title[0..100] + "...","bsdsec",{url: "http://bsdsec.net/articles/#{c.friendly_id}"})
    else
      Email.create(from: email.from.to_s, to: email.to.to_s, cc: email.cc.to_s, subject: email.subject, body: email.body) unless n[0]==nil
    end
  end	
end