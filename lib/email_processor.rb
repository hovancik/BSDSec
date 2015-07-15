class EmailProcessor
  def initialize(email)
    @email = email
  end
  
  def tag_list_to_hashtag tag_list
    tag_list.split(',').map {|i| "##{i} " }.join
  end
  
  def create_article(tag_list)
    reddit_client = RedditKit::Client.new ENV["reddit_name"], ENV["reddit_pass"] 
    reddit_client.user_agent = "BSDSec.net"
    a = Article.create(title: @email.subject, body: @email.body, from: @email.from[:email].to_s, tag_list: tag_list.downcase)
    $client.update(@email.subject[0..100] + "... #{tag_list_to_hashtag(tag_list)}https://bsdsec.net/articles/#{a.friendly_id}")
    reddit_client.submit(a.title[0..100] + "...","bsdsec",{url: "https://bsdsec.net/articles/#{a.friendly_id}"})
  end  
  
  def find_list
    n=""
    acceptable_to = ["announce@freebsd.org", "errata-notices@freebsd.org", "announce@openbsd.org","freebsd-announce@freebsd.org", "netbsd-announce@netbsd.org", "security-advisories@freebsd.org","midnightbsd-security@midnightbsd.org", "security-announce@lists.pfsense.org"]
    to = @email.to.map {|a| a[:email].downcase}
    cc = @email.cc.map {|a| a[:email].downcase}
    n= acceptable_to & to + cc
  end  
  
  def process
    case find_list[0]
    when "announce@openbsd.org"
      create_article("OpenBSD")
    when "freebsd-announce@freebsd.org"
      create_article("FreeBSD")
    when "announce@freebsd.org"
      create_article("FreeBSD")  
    when "security-advisories@freebsd.org"
      create_article("FreeBSD")
    when "errata-notices@freebsd.org"
      create_article("FreeBSD")
    when "midnightbsd-security@midnightbsd.org"
      create_article("MidnightBSD")
    when "netbsd-announce@netbsd.org"
      create_article("NetBSD")
    when "security-announce@lists.pfsense.org"
      create_article("pfSense")
    else
      Email.create(from: @email.from[:email].to_s, to: @email.to.map {|a| a[:email].downcase}.to_s, cc: @email.cc.map {|a| a[:email].downcase}.to_s, subject: @email.subject, body: @email.body) #unless n[0]==nil
    end
  end	
end