class Word < ActiveRecord::Base
  belongs_to :category

  has_many :question_choices, dependent: :destroy
  has_many :user_answers, dependent: :destroy

  has_many :learnt_word_maps, dependent: :destroy

  accepts_nested_attributes_for :question_choices, allow_destroy: true

  validates :text, presence: true, length: {maximum: 255}
  validates :meaning, presence: true, length: {maximum: 255}

  has_attached_file :pronunciation, default_url: nil
  validates_attachment :pronunciation,
    content_type: {content_type: ["audio/mp3", "audio/mpeg"]},
    size: [in: 0..1000.kilobytes]

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

  def get_correct_answer
    self.question_choices
      .correct
      .map{|question_choice| question_choice.text}
      .join('/')
  end
end
