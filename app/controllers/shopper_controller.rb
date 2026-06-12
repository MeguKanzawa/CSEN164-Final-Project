class ShopperController < ApplicationController

  include CurrentCart
  before_action(:set_cart) # set_cart is an instance method of ShopperController class
  before_action :resume_session, only: [:index]

  def index
    @allproducts = Product.all
  end
end
