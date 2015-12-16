class Word < ActiveRecord::Base
  belongs_to :category

  has_many :question_choices
  has_many :user_answers

  def get_correct_answer
    self.question_choices
      .correct
      .map{|question_choice| question_choice.text}
      .join('/')
  end
end