class Admin::CategoriesController < ApplicationController
  include Authorization

  before_action :require_admin
  before_action :set_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.preload(:words).all.page(params[:page])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params

    if @category.save
      flash[:success] = I18n.t "success.create"
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update category_params
      flash[:success] = I18n.t "success.update"
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = I18n.t "success.delete"
    else
      flash[:error] = I18n.t "error.general"
    end

    redirect_to admin_categories_path
  end

  private
  def set_category
    @category = Category.find params[:id]
  end

  def category_params
    params.require(:category).permit(:name, :cover_photo)
  end
end