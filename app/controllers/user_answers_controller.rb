class UserAnswersController < ApplicationController
  include Authorization

  before_action :require_login, only: [:show, :update]
  before_action :set_answer, only: [:show, :update]
  before_action ->{require_ownership @answer.lesson.user_id}, only: [:show, :update]

  def show
    @answer = UserAnswer.find_by(
      lesson_id:  params[:lesson_id],
      order:      params[:order]
    )
  end

  def update
    @answer = UserAnswer.find_by(
      lesson_id:  params[:lesson_id],
      order:      params[:order]
    )
  end

  def update
    if !@answer.submit params[:choice_id]
      flash[:error] = I18n.t "error.general"
    end

    redirect_to lesson_user_answer_path(params[:lesson_id], params[:order])
  end

  private
  def set_answer
    @answer = UserAnswer.find_by(
      lesson_id:  params[:lesson_id],
      order:      params[:order]
    )
  end
end
