module ApplicationHelper

  def art_title(text)
    text.sub("[FreeBSD-Announce]","").sub("[Midnightbsd-security]","")
  end

  def art_body(text)
    text
  end

  def art_mail(text)
    text
  end

  def art_date(text)
    text.strftime("%e %B, %Y")
  end
end
