class Word < ActiveRecord::Base
  belongs_to :category

  has_many :question_choices
  has_many :user_answers
end
