class OrdersController < ApplicationController
  include CurrentCart
  before_action(:set_cart) # set @cart
  before_action :set_order, only: %i[ show edit update destroy ]

  # GET /orders or /orders.json
  def index
    if Current.user.admin?
      @orders = Order.all
    else
      @orders = Current.user.orders
    end
  end

  # GET /orders/1 or /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders or /orders.json
  def create
    @order = Current.user.orders.build(order_params)
    
    @order.add_order_id_to_cartitem_table(@cart)

    respond_to do |format|
      if @order.save
        @cart.destroy if @cart
        session[:cart_id] = nil
        format.html { redirect_to @order, notice: "Order was successfully created." }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @order.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: "Order was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @order.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy!

    respond_to do |format|
      format.html { redirect_to orders_path, notice: "Order was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:name, :address, :email, :paytype)
    end
end
