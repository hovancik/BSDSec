module ApplicationHelper

  def art_title(text)
    text.sub("[FreeBSD-Announce]","").sub("[Midnightbsd-security]","")
  end

  def art_date(text)
    text.strftime("%e %B, %Y")
  end

  def art_body(text)
    text.lines.map { |c| c.unpack("M*") }.join.force_encoding('UTF-8')
  end

  def motif_image_url(url: root_url)
    "https://motif.imgix.com/i?url=#{u url}&image_url=#{u image_url '/img/pankaj-patel-fvMeP4ml4bU-unsplash.jpg' }&color=332e56&logo_url=#{u image_url '/img/bsdsec.png' }&logo_alignment=top%2Ccenter&text_alignment=bottom%2Ccenter&logo_padding=70&font_family=Avenir%20Next%20Demi%2CBold&text_color=332e56"
  end

  # Inline SVG icons from Tabler Icons (MIT License)
  # https://tabler.io/icons
  def icon(name, options = {})
    css_class = ["icon", options[:class]].compact.join(" ")

    icons = {
      rss: '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M5 19m-1 0a1 1 0 1 0 2 0a1 1 0 1 0 -2 0"/><path d="M4 4a16 16 0 0 1 16 16"/><path d="M4 11a9 9 0 0 1 9 9"/></svg>',
      github: '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M9 19c-4.3 1.4 -4.3 -2.5 -6 -3m12 5v-3.5c0 -1 .1 -1.4 -.5 -2c2.8 -.3 5.5 -1.4 5.5 -6a4.6 4.6 0 0 0 -1.3 -3.2a4.2 4.2 0 0 0 -.1 -3.2s-1.1 -.3 -3.5 1.3a12.3 12.3 0 0 0 -6.2 0c-2.4 -1.6 -3.5 -1.3 -3.5 -1.3a4.2 4.2 0 0 0 -.1 3.2a4.6 4.6 0 0 0 -1.3 3.2c0 4.6 2.7 5.7 5.5 6c-.6 .6 -.6 1.2 -.5 2v3.5"/></svg>'
    }

    svg = icons[name.to_sym]
    return "" unless svg

    # Add class to the SVG
    svg.sub('<svg ', "<svg class=\"#{css_class}\" ").html_safe
  end
end
