class FollowingsController < ApplicationController
  include Authorization

  before_action :require_login
  before_action :set_following, only: [:destroy]

  def create
    following = Following.new following_params

    unless following.save!
      flash[:error] = I18n.t "error.general"
    end

    redirect_to :back
  end

  def destroy
    unless @following.destroy
      flash[:error] = I18n.t "error.general"
    end

    redirect_to :back
  end

  private
  def following_params
    params[:follower_id] = current_user.id
    params.permit(:user_id, :follower_id)
  end

  def set_following
    @following = Following.find_by(
      follower_id: current_user.id,
      user_id: params[:user_id]
    )
  end
end
