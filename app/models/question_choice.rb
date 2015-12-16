class QuestionChoice < ActiveRecord::Base
  belongs_to :word
  has_one :user_answer, dependent: :destroy

  validates :text, presence: true, length: {maximum: 255}

  scope :correct, ->{where correct: true}
end
