class UsersController < ApplicationController
  include CurrentCart
  before_action :set_cart
  before_action :resume_session, only: [:new]
  allow_unauthenticated_access only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      # creates session token immediately upon successful signup
      start_new_session_for @user
      redirect_to root_path, notice: "Successfully signed up!"
    else
      render :new, status: :unprocessable_entity
    end
  end 

  private 

  def user_params
    params.require(:user).permit(:email_address, :password)
  end
end