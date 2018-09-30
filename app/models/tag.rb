class Tag < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :taggings, dependent: :destroy
  has_many :articles, through: :taggings

  def to_s
    name
  end
end
