class EmailProcessor
  def self.process(email)
    n=""
    acceptable_to = ["announce@openbsd.org","freebsd-announce@freebsd.org", "netbsd-announce@netbsd.org"]
    email.to.each do |t|
      t.downcase!
      n= acceptable_to.find_all{|item| t.include? item }
    end
    case n
    when "announce@openbsd.org"
      a = Article.create(title: email.subject, body: email.body, from: email.from.to_s, tag_list: "openbsd")
      $client.update(email.subject+ " #OpenBSD http://bsdsec.net/articles/#{c.friendly_id}")
    when "freebsd-announce@freebsd.org"
      b = Article.create(title: email.subject, body: email.body, from: email.from.to_s, tag_list: "freebsd")
      $client.update(email.subject+ " #FreeBSD http://bsdsec.net/articles/#{c.friendly_id}")
    when "security-officer@netbsd.org"
      c = Article.create(title: email.subject, body: email.body, from: email.from.to_s, tag_list: "netbsd")
      $client.update(email.subject+ " #NetBSD http://bsdsec.net/articles/#{c.friendly_id}")
    else
      Email.create(from: email.from.to_s, to: email.to.to_s, cc: email.cc.to_s, subject: email.subject, body: email.body)
    end
  end	
end