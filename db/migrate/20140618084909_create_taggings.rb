class CreateTaggings < ActiveRecord::Migration[4.2]
  def change
    create_table :taggings do |t|
      t.references :tag, index: true
      t.references :article, index: true

      t.timestamps
    end
  end
end
