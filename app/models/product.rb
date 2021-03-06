class Product < ApplicationRecord
  include ActiveModel::Serializers::Xml

  has_many :line_items
  has_many :orders, through: :line_items

  validates :title, :description, :image_url, presence: true
  validates :title, uniqueness: true
  validates :title, length: { minimum: 10 }
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :image_url,
            allow_blank: true,
            format: {
              with: /\.(gif|jpe*g|png)\Z/i,
              message: 'must be a URL for GIF, JPG, JPEG or PNG image.'
            }

  before_destroy :ensure_not_referenced_by_any_line_item

  private

  def ensure_not_referenced_by_any_line_item
    return if line_items.empty?

    errors.add(:base, 'Line Items present')
    throw :abort
  end
end
