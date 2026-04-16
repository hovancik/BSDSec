class BsdsecMailbox < ApplicationMailbox
  ALLOWED_FROM_DOMAINS = ["openbsd.org", "freebsd.org", "netbsd.org",
                          "midnightbsd.org", "pfsense.org"].freeze

  rescue_from(StandardError) do |exception|
    begin
      Rollbar.error(
        exception,
        mailbox: self.class.name,
        message_id: mail&.message_id,
        to: mail&.to,
        cc: mail&.cc
      )
    rescue StandardError
      nil
    end
    raise exception
  end

  def process
    list_address = email_list_address

    if test_email && list_address == test_email
      create_article("Test")
      return
    end

    unless from_allowed?
      store_email
      return
    end

    case list_address
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
      store_email
    end
  end

  private

  def create_article(tag_list)
    article = Article.create(title: mail.subject, body: mail.body,
                             from: mail.from.first,
                             tag_list: tag_list.downcase)
  end

  def store_email
    Email.create(from: mail.from.first,
                 to: tos.join(', '),
                 cc: ccs.join(', '),
                 subject: mail.subject, body: mail.body)
  end

  def from_allowed?
    from_address = mail.from&.first&.downcase
    return false unless from_address&.include?("@")
    domain = from_address.split("@").last
    ALLOWED_FROM_DOMAINS.include?(domain)
  end

  def email_list_address
    acceptable_to = ["announce@freebsd.org", "errata-notices@freebsd.org",
                     "announce@openbsd.org", "freebsd-announce@freebsd.org",
                     "netbsd-announce@netbsd.org", "announce@netbsd.org",
                     "security-advisories@freebsd.org", "core@freebsd.org",
                     "midnightbsd-security@midnightbsd.org",
                     "security-announce@lists.pfsense.org"]
    acceptable_to << test_email if test_email
    (acceptable_to & (tos + ccs)).first
  end

  def test_email
    ENV["TEST_EMAIL"]&.strip&.downcase.presence
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
