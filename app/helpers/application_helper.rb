module ApplicationHelper

  def art_title(text)
    text.sub("[FreeBSD-Announce]","").sub("[Midnightbsd-security]","")
  end

  def art_date(text)
    text.strftime("%e %B, %Y")
  end

  def art_body(text)
    text.lines.map { |c| c.unpack("M*") }.join
  end

  def motif_image_url(url: root_url)
    "https://motif.imgix.com/i?url=#{u url}&image_url=#{u image_url '/img/pankaj-patel-fvMeP4ml4bU-unsplash.jpg' }&color=b1d6f4&logo_url=#{u image_url '/img/bsdsec.png' }&logo_alignment=top%2Ccenter&text_alignment=bottom%2Ccenter&logo_padding=70&font_family=Avenir%20Next%20Demi%2CBold&text_color=1d1d1d"
  end
end
