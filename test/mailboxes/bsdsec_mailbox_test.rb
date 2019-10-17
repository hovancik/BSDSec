require "test_helper"

class BsdsecMailboxTest < ActionMailbox::TestCase
  test "create article when BSD email in TO" do
    assert_difference -> { Article.all.count } do
      receive_inbound_email_from_mail \
        to: 'Announce@freebsd.org',
        from: 'john@example.com',
        subject: 'FreeBSD SA12',
        body: <<~BODY
          New SA.
        BODY
    end

    assert_equal Article.last.title, 'FreeBSD SA12'
    assert_equal Article.last.body, "New SA.\n"
    assert_equal Article.last.from, 'john@example.com'
  end

  test "create article when BSD email in TOs" do
    assert_difference -> { Article.all.count } do
      receive_inbound_email_from_mail \
        to: 'josua@example.com , Announce@freebsd.org',
        from: 'john@example.com',
        subject: 'FreeBSD SA12',
        body: <<~BODY
          New SA.
        BODY
    end

    assert_equal Article.last.title, 'FreeBSD SA12'
    assert_equal Article.last.body, "New SA.\n"
    assert_equal Article.last.from, 'john@example.com'
  end

  test "create article when BSD email in CC" do
    assert_difference -> { Article.all.count } do
      receive_inbound_email_from_mail \
        cc: 'Announce@freebsd.org',
        from: 'john@example.com',
        subject: 'FreeBSD SA12',
        body: <<~BODY
          New SA.
        BODY
    end

    assert_equal Article.last.title, 'FreeBSD SA12'
    assert_equal Article.last.body, "New SA.\n"
    assert_equal Article.last.from, 'john@example.com'
  end

  test "create article when BSD email in CCs" do
    assert_difference -> { Article.all.count } do
      receive_inbound_email_from_mail \
        cc: 'joshua@example.com, Announce@freebsd.org',
        from: 'john@example.com',
        subject: 'FreeBSD SA12',
        body: <<~BODY
          New SA.
        BODY
    end

    assert_equal Article.last.title, 'FreeBSD SA12'
    assert_equal Article.last.body, "New SA.\n"
    assert_equal Article.last.from, 'john@example.com'
  end

  test "create email when no correct list" do
    assert_difference -> { Email.all.count } do
      receive_inbound_email_from_mail \
        cc: 'joshua@example.com',
        from: 'john@example.com',
        subject: 'FreeBSD SA12',
        body: <<~BODY
          New SA.
        BODY
    end

    assert_equal Email.last.subject, 'FreeBSD SA12'
    assert_equal Email.last.body, "New SA.\n"
    assert_equal Email.last.from, 'john@example.com'
    assert_equal Email.last.cc, 'joshua@example.com'
    assert_equal Email.last.to, ''
  end
end
