class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart
  belongs_to :order, optional: true

  validates :quantity, presence: true, numericality: { integer_only: true, greater_than_or_equal_to: 1 }

  def total_price
    unit_price * quantity
  end
end
