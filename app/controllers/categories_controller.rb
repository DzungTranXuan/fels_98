class CategoriesController < ApplicationController
  def index
    @categories = Category.preload(:words).all.page(params[:page])
  end
end
