class Word < ActiveRecord::Base
  belongs_to :category

  has_many :question_choices
  has_many :user_answers

  has_many :learnt_word_maps

  paginates_per 20

  FILTERS = [
    {id: 1, key: :all},
    {id: 2, key: :learnt},
    {id: 3, key: :not_learnt}
  ]

  class << self
    def filter category_id, filter_id, user_id
      filter = FILTERS.detect {|filter| filter[:id] == filter_id}

      case filter[:key]
      when :all
        words = Word.where(category_id: category_id)
      when :learnt
        user = User.find user_id
        words = user.learnt_words.where(category_id: category_id)
      when :not_learnt
        user = User.find user_id
        words = Word.where(category_id: category_id) - user.learnt_words.where(category_id: category_id)
      end

      words
    end
  end
end
