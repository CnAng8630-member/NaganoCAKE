class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items

  enum payment_method: {credit_card: 0, transfer: 1}

  def subtotal
    item_total_amount + postage
  end
end
