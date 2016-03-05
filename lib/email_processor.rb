class EmailProcessor
  def initialize(email)
    @email = email
  end

  def tag_list_to_hashtag(tag_list)
    tag_list.split(",").map { |i| "##{i} " }.join
  end

  def create_article(tag_list)
    article = Article.create(title: @email.subject, body: @email.body,
                             from: @email.from[:email].to_s,
                             tag_list: tag_list.downcase)
    f_id = article.friendly_id
    twitter_client.update(@email.subject[0..100] +
      "... #{tag_list_to_hashtag(tag_list)} \
      https://bsdsec.net/articles/#{f_id}")
    reddit_client.submit(article.title[0..100] + "...",
                         "bsdsec",
                         url: "https://bsdsec.net/articles/#{f_id}")
  end

  def find_list
    acceptable_to = ["announce@freebsd.org", "errata-notices@freebsd.org",
                     "announce@openbsd.org", "freebsd-announce@freebsd.org",
                     "netbsd-announce@netbsd.org", "announce@netbsd.org",
                     "security-advisories@freebsd.org",
                     "midnightbsd-security@midnightbsd.org",
                     "security-announce@lists.pfsense.org"]
    to = @email.to.map { |a| a[:email].downcase }
    cc = @email.cc.map { |a| a[:email].downcase }
    acceptable_to & to + cc
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
    when "announce@netbsd.org"
      create_article("NetBSD")
    when "security-announce@lists.pfsense.org"
      create_article("pfSense")
    else
      Email.create(from: @email.from[:email].to_s,
                   to: @email.to.map { |a| a[:email].downcase }.to_s,
                   cc: @email.cc.map { |a| a[:email].downcase }.to_s,
                   subject: @email.subject, body: @email.body)
    end
  end

  private

  def reddit_client
    reddit_client = RedditKit::Client.new ENV["reddit_name"], ENV["reddit_pass"]
    reddit_client.user_agent = "BSDSec.net"
    reddit_client
  end

  def twitter_client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["twitter_consumer_key"]
      config.consumer_secret     = ENV["twitter_consumer_secret"]
      config.access_token        = ENV["twitter_access_token"]
      config.access_token_secret = ENV["twitter_access_token_secret"]
    end
  end
end
