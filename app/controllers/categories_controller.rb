class CategoriesController < ApplicationController
  def index
    @categories = Category.all.page(params[:page])
  end
end
