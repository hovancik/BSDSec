class EmailProcessor
  def self.process(email)
    acceptable_to = ["announce@openbsd.org","freebsd-announce@freebsd.org", "netbsd-announce@netbsd.org","test@bsdsec.tk"]
    email.to.each {|a| a.downcase!}
    to = acceptable_to & email.to
    case to[0]
    when "announce@openbsd.org"
      a = Article.create(title: email.subject, body: email.body, from: email.from.to_s, tag_list: "openbsd", raw_body: email.raw_body, raw_text: email.raw_text, raw_html: email.raw_html)
      $client.update(email.subject+ " #OpenBSD")
    when "freebsd-announce@freebsd.org"
      b = Article.create(title: email.subject, body: email.body, from: email.from.to_s, tag_list: "freebsd", raw_body: email.raw_body, raw_text: email.raw_text, raw_html: email.raw_html)
      $client.update(email.subject+ " #FreeBSD")
    when "security-officer@netbsd.org"
      c = Article.create(title: email.subject, body: email.body, from: email.from.to_s, tag_list: "netbsd", raw_body: email.raw_body, raw_text: email.raw_text, raw_html: email.raw_html)
      $client.update(email.subject+ " #NetBSD")
    when "test@bsdsec.tk"
      d = Article.create(title: email.subject, body: email.body, from: email.from.to_s, tag_list: "bsdsec", raw_body: email.raw_body, raw_text: email.raw_text, raw_html: email.raw_html)
      $client.update(email.subject+ " #BSDSec")    
    else
      Email.create(from: email.from.to_s, to: email.to.to_s, cc: email.cc.to_s, subject: email.subject, body: email.body, raw_body: email.raw_body, raw_text: email.raw_text, raw_html: email.raw_html)
    end
  end	
end