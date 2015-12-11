class LessonsController < ApplicationController
  include Authorization

  before_action :require_login, only: [:create, :show]
  before_action :set_lesson, only: [:show]
  before_action ->{require_ownership @lesson.user_id}, only: [:show]

  def create
    lesson = Lesson.new(lesson_params)

    if lesson.save!
      redirect_to lesson_user_answer_path(lesson.id, 1)
    else
      flash[:error] = I18n.t "error.general"
      redirect :back
    end
  end

  def show
  end

  private
  def lesson_params
    params[:user_id] = current_user.id
    params.permit(:user_id, :category_id)
  end

  def set_lesson
    @lesson = Lesson.preload(user_answers: [:word]).find(params[:id])
  end
end