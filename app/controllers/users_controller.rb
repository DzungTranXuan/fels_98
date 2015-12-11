class UsersController < ApplicationController
  include Authorization

  before_action :require_login
  before_action ->{require_ownership params[:id].to_i}, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update]

  def index
    @users = User.all.page params[:page]
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :avatar)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
