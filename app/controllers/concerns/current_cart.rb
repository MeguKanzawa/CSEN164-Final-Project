module CurrentCart 
  extend ActiveSupport::Concern
  
  # figure out cart object
  def set_cart
    @cart = Cart.find(session[:cart_id])
  # if fails
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create() # automatically, we have cart_id
    session[:cart_id] = @cart.id
  end
end