class Order < ApplicationRecord
  belongs_to :user

  def add_order_id_to_cartitem_table(cart)
    cart.cartitems.each do |item|
      item.cart_id = nil
      item.order_id = self.id
    end
  end
end
