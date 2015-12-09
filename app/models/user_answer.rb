class UserAnswer < ActiveRecord::Base
  belongs_to :user
  belongs_to :word
  belongs_to :question_choice
  belongs_to :lesson

  def update_choice choice_id
    self.question_choice_id = choice_id
    self.correct = self.question_choice.correct
    self.save!
  end
end
