class UserAnswersController < ApplicationController
  include Authorization

  before_action :require_login, only: [:show]

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

    if !@answer.update_choice params[:choice_id]
      flash[:error] = I18n.t "error.general"
    end

    redirect_to lesson_show_question_path(params[:lesson_id], params[:order])
  end
end
