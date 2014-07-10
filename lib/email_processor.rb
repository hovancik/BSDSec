class EmailProcessor
  def self.process(email)
    acceptable_to = ["announce@openbsd.org","freebsd-announce@freebsd.org", "netbsd-announce@netbsd.org","test@bsdsec.tk"]
    to = acceptable_to & email.to
    case to[0]
    when "announce@openbsd.org"
        a = Article.create(title: email.subject, body: email.raw_html, from: email.from.to_s)
        a.tags.create name: 'openbsd'
        $client.update(email.subject+ " #OpenBSD")
    when "freebsd-announce@freebsd.org"
        b = Article.create(title: email.subject, body: email.raw_html, from: email.from.to_s)
        b.tags.create name: 'freebsd'
        $client.update(email.subject+ " #FreeBSD")
    when "security-officer@netbsd.org"
        c = Article.create(title: email.subject, body: email.raw_html, from: email.from.to_s)
        c.tags.create name: 'netbsd'
        $client.update(email.subject+ " #NetBSD")
    when "test@bsdsec.tk"
      d = Article.create(title: email.subject, body: email.raw_html, from: email.from.to_s)
      d.tags.create name: 'bsdsec'
      $client.update(email.subject+ " #BSDSec")    
    else
        Email.create(from: email.from.to_s, to: email.to.to_s, cc: email.cc.to_s, subject: email.subject, body: email.body)
    end
    
  end	
end