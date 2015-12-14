class Admin::WordsController < ApplicationController
  include Authorization

  before_action :require_admin
  before_action :set_word, only: [:edit, :update, :destroy]

  def index
    @words = Word.preload(:category, :question_choices).order(id: :DESC).page(params[:page])
  end

  def new
    @word = Word.new
  end

  def create
    @word = Word.new word_params

    if @word.save
      flash[:success] = I18n.t "success.create"
      redirect_to admin_words_path
    else
      flash[:error] = I18n.t "error.general"
      render :new
    end
  end

  def edit
  end

  def update
    if @word.update word_params
      flash[:success] = I18n.t "success.update"
      redirect_to admin_words_path
    else
      render :edit
    end
  end

  def destroy
    if @word.destroy
      flash[:success] = I18n.t "success.delete"
    else
      flash[:error] = I18n.t "error.general"
    end

    redirect_to admin_words_path
  end


  private
  def word_params
    params.require(:word)
      .permit(
        :text,
        :meaning,
        :category_id,
        question_choices_attributes: [:id, :text, :correct, :_destroy]
      )
  end

  def set_word
    @word = Word.find(params[:id])
  end
end
