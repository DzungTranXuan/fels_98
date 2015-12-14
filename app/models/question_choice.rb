class QuestionChoice < ActiveRecord::Base
  belongs_to :word
  has_one :user_answer, dependent: :destroy
end
