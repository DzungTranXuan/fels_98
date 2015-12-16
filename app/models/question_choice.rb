class QuestionChoice < ActiveRecord::Base
  belongs_to :word

  scope :correct, ->{where correct: true}
end
