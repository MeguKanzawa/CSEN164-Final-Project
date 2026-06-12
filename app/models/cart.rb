class Cart < ApplicationRecord
  has_many(:cartitems, dependent: :destroy)

  def add_cartitem(product_id)
    current_item = self.cartitems.find_by(product_id: product_id)
    if current_item 
      current_item.quantity += 1
    else
      current_item = self.cartitems.build(product_id: product_id)
    end
    current_item
  end

  def total_price
    self.cartitems.to_a.sum do |item|
      item.item_total_price
    end
  end
end
