class BsdsecMailbox < ApplicationMailbox
  rescue_from(StandardError) do |exception|
    Rollbar.error(
      exception,
      mailbox: self.class.name,
      message_id: mail.message_id,
      email_list_address: email_list_address
    )
    raise
  end

  def process
    case email_list_address
    when ENV["TEST_EMAIL"].presence
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

  def create_article(tag_list)
    article = Article.create(title: mail.subject, body: mail.body,
                             from: mail.from.first,
                             tag_list: tag_list.downcase)
  end

  def email_list_address
    acceptable_to = ["announce@freebsd.org", "errata-notices@freebsd.org",
                     "announce@openbsd.org", "freebsd-announce@freebsd.org",
                     "netbsd-announce@netbsd.org", "announce@netbsd.org",
                     "security-advisories@freebsd.org", "core@freebsd.org",
                     "midnightbsd-security@midnightbsd.org",
                     "security-announce@lists.pfsense.org"]
    test_email = ENV["TEST_EMAIL"]
    acceptable_to << test_email if test_email.present?
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
end
