class LessonsController < ApplicationController
  include Authorization

  before_action :require_login, only: [:create]

  def create
    lesson = Lesson.create({
        category_id:  params[:category_id],
        user_id:      current_user.id
      })

    if lesson.save!
      redirect_to lesson_show_question_path(lesson.id, 1)
    else
      flash[:error] = I18n.t "error.general"
      redirect :back
    end
  end

  def result
  end
end
