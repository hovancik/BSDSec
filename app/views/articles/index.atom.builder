atom_feed do |feed|
  feed.title("BSDSec")
  feed.updated(@articles[0].created_at) if @articles.length > 0

  @articles.each do |article|
    feed.entry(article) do |entry|
      entry.title(article.title)
      entry.content(article.body, type: 'html')
      entry.tags(article.tag_list)
      entry.author do |author|
        author.name(article.from)
      end
    end
  end
end
