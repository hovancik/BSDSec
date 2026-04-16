require "test_helper"

class BsdsecMailboxTest < ActionMailbox::TestCase
  test "create article when BSD email in TO with valid List-Id" do
    assert_difference -> { Article.all.count } do
      receive_inbound_email_from_mail \
        to: 'Announce@freebsd.org',
        from: 'john@example.com',
        subject: 'FreeBSD SA12',
        headers: { "List-Id" => "<freebsd-announce.freebsd.org>" },
        body: <<~BODY
          New SA.
        BODY
    end

    assert_equal Article.last.title, 'FreeBSD SA12'
    assert_equal Article.last.body, "New SA.\n"
    assert_equal Article.last.from, 'john@example.com'
  end

  test "create article when BSD email in TOs with valid List-Id" do
    assert_difference -> { Article.all.count } do
      receive_inbound_email_from_mail \
        to: 'josua@example.com , Announce@freebsd.org',
        from: 'john@example.com',
        subject: 'FreeBSD SA12',
        headers: { "List-Id" => "FreeBSD Announce <announce.freebsd.org>" },
        body: <<~BODY
          New SA.
        BODY
    end

    assert_equal Article.last.title, 'FreeBSD SA12'
    assert_equal Article.last.body, "New SA.\n"
    assert_equal Article.last.from, 'john@example.com'
  end

  test "create article when BSD email in CC with valid List-Id" do
    assert_difference -> { Article.all.count } do
      receive_inbound_email_from_mail \
        cc: 'Announce@freebsd.org',
        from: 'john@example.com',
        subject: 'FreeBSD SA12',
        headers: { "List-Id" => "<announce.freebsd.org>" },
        body: <<~BODY
          New SA.
        BODY
    end

    assert_equal Article.last.title, 'FreeBSD SA12'
    assert_equal Article.last.body, "New SA.\n"
    assert_equal Article.last.from, 'john@example.com'
  end

  test "create article when BSD email in CCs with valid List-Id" do
    assert_difference -> { Article.all.count } do
      receive_inbound_email_from_mail \
        cc: 'joshua@example.com, Announce@freebsd.org',
        from: 'john@example.com',
        subject: 'FreeBSD SA12',
        headers: { "List-Id" => "<announce.freebsd.org>" },
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

  test "create email instead of article when List-Id header is missing" do
    assert_no_difference -> { Article.all.count } do
      assert_difference -> { Email.all.count } do
        receive_inbound_email_from_mail \
          to: 'Announce@freebsd.org',
          from: 'skl246@proton.me',
          subject: 'Spam subject',
          body: <<~BODY
            Spam body.
          BODY
      end
    end

    assert_equal Email.last.subject, 'Spam subject'
    assert_equal Email.last.from, 'skl246@proton.me'
  end

  test "create email instead of article when List-Id header does not match" do
    assert_no_difference -> { Article.all.count } do
      assert_difference -> { Email.all.count } do
        receive_inbound_email_from_mail \
          to: 'Announce@freebsd.org',
          from: 'skl246@proton.me',
          subject: 'Spam subject',
          headers: { "List-Id" => "<some-random-list.example.com>" },
          body: <<~BODY
            Spam body.
          BODY
      end
    end

    assert_equal Email.last.subject, 'Spam subject'
    assert_equal Email.last.from, 'skl246@proton.me'
  end
end
