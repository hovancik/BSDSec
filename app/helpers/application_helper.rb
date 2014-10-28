module ApplicationHelper

  def art_title(text)
    text.sub("[FreeBSD-Announce]","").sub("[Midnightbsd-security]","")
  end
  
  def art_body(text)
    auto_link(text, :html => { :target => '_blank', :rel => 'nofollow' }).html_safe
  end
  
  def art_mail(text)
    text #.sub("@","(at)").sub(".","(dot)")
  end
  
  def art_date(text)
    text.strftime("%e %B, %Y")
  end
end
