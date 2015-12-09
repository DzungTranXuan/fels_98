class LessonsController < ApplicationController
  include Authorization

  before_action :require_login, only: [:create, :result]


  def create
    lesson = Lesson.new({
      category_id:  params[:category_id],
      user_id:      current_user.id
    })

    if lesson.save!
      redirect_to lesson_user_answer_path(lesson.id, 1)
    else
      flash[:error] = I18n.t "error.general"
      redirect :back
    end
  end

  def result
    @lesson = Lesson.find(params[:lesson_id])

    require_ownership @lesson.user_id
  end
end
