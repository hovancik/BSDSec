module ApplicationHelper

  def art_title(text)
    text.sub("[FreeBSD-Announce]","").sub("[Midnightbsd-security]","")
  end

  def art_date(text)
    text.strftime("%e %B, %Y")
  end

  def motif_image_url(url: root_url)
    "https://motif.imgix.com/i?url=#{u url}&image_url=#{u image_url '/img/pasture-fence-1995820_1920.jpg' }&color=6e6e6e&logo_url=&logo_alignment=bottom%2Cright&text_alignment=top%2Cleft&logo_padding=0&font_family=Avenir%20Next%20Demi%2CBold&text_color=ffffff"
  end
end
