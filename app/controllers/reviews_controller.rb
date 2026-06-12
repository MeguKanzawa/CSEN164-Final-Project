class ReviewsController < ApplicationController
  include CurrentCart
  before_action :set_cart
  before_action :set_product
  before_action :set_review, only: %i[ show edit update destroy ]

  # GET /reviews or /reviews.json
  def index
    @reviews = Review.all
  end

  # GET /reviews/1 or /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews or /reviews.json
  def create
    @review = @product.reviews.build(review_params)
    @review.user = Current.user

    respond_to do |format|
      if @review.save
        format.html { redirect_to @product, notice: "Review was successfully created." }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @review.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /reviews/1 or /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @review, notice: "Review was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @review.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /reviews/1 or /reviews/1.json
  def destroy
    @review.destroy!

    respond_to do |format|
      format.html { redirect_to @product, notice: "Review was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  def average_rating
    @all_reviews = @product.reviews
    
    @all_reviews_sum = 0
    @all_reviews.each do |review|
      @all_reviews_sum += review.rating 
    end

    @all_reviews_sum / @all_reviews.size

  end

  private

    def set_product
      @product = Product.find(params[:product_id])
    end

    def set_review
      @review = @product.reviews.find(params[:id])
    end

    def set_review
      @review = Review.find(params.expect(:id))
    end

    def review_params
      params.expect(review: [ :rating, :comment ])
    end
end
