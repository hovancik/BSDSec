class BsdsecMailbox < ApplicationMailbox
  def process
    case email_list_address
    when ENV.fetch("TEST_EMAIL")
      create_article("Test")
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
    when "core@freebsd.org"
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
      Email.create(from: mail.from.first,
                   to: tos.join(', '),
                   cc: ccs.join(', '),
                   subject: mail.subject, body: mail.body)
    end
  end

  private

  def tag_list_to_hashtag(tag_list)
    tag_list.split(",").map { |i| "##{i} " }.join
  end

  def create_article(tag_list)
    article = Article.create(title: mail.subject, body: mail.body,
                             from: mail.from.first,
                             tag_list: tag_list.downcase)
    f_id = article.friendly_id
    if ENV.fetch("TWITTER", nil)
      payload = {
        text: "#BSDSec #{mail.subject[0..100]}... \r\n" \
          "#{tag_list_to_hashtag(tag_list)} \r\n" \
          "https://bsdsec.net/articles/#{f_id}"
      }.to_json
      twitter_client.post('tweets', payload)
    end
  end

  def email_list_address
    acceptable_to = ["announce@freebsd.org", "errata-notices@freebsd.org",
                     "announce@openbsd.org", "freebsd-announce@freebsd.org",
                     "netbsd-announce@netbsd.org", "announce@netbsd.org",
                     "security-advisories@freebsd.org", "core@freebsd.org",
                     "midnightbsd-security@midnightbsd.org",
                     "security-announce@lists.pfsense.org", ENV.fetch("TEST_EMAIL")]
    (acceptable_to & tos + ccs).first
  end

  def tos
    if mail.to.present?
      mail.to.map(&:downcase)
    else
      []
    end
  end

  def ccs
    if mail.cc.present?
      mail.cc.map(&:downcase)
    else
      []
    end
  end

  def twitter_client
    x_credentials = {
      api_key: ENV['TWITTER_CONSUMER_KEY'],
      api_key_secret: ENV['TWITTER_CONSUMER_SECRET'],
      access_token: ENV['TWITTER_ACCESS_TOKEN'],
      access_token_secret: ENV['TWITTER_ACCESS_SECRET']
    }
    X::Client.new(**x_credentials)
  end
end
