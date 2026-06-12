class Product < ApplicationRecord
  validates(:name, :description, :image, presence:true)
  validates(:price, numericality: {greater_than_or_equal_to: 0.01})
  validates(:image, format: {
    with: %r(\.(gif|jpg|png)\Z)i, 
    message: 'must be GIF, JPG, PNG Images'
  })
  validates(:name, uniqueness: true)
  has_many(:cartitems)
  has_many :reviews, dependent: :destroy

  before_destroy(:make_sure_no_cart_items_under_this_product) 

  def make_sure_no_cart_items_under_this_product 
    # cart items under this product is empty
    if self.cartitems.empty?
      return true
    else
      return false
    end
  end
end
