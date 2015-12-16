class WordsController < ApplicationController
  include Authorization

  before_action :require_login, only: [:index]

  def index
    category_id = params[:category] ? params[:category].to_i : Category.first.id
    filter_id = params[:filter] ? params[:filter].to_i : Word::FILTERS.first[:id]

    words = Word.filter(category_id, filter_id, current_user.id)

    @data = {
      words:                words,
      categories:           Category.all,
      selected_category_id: category_id,
      filters:              Word::FILTERS,
      selected_filter_id:   filter_id
    }
  end
end