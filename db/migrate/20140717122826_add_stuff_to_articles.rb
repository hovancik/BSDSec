class AddStuffToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :raw_body, :text
    add_column :articles, :raw_text, :text
    add_column :articles, :raw_html, :text
  end
end
