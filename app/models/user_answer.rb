class UserAnswer < ActiveRecord::Base
  belongs_to :user
  belongs_to :word
  belongs_to :question_choice
  belongs_to :lesson

  after_save :update_learnt_words

  def update_choice choice_id
    self.question_choice_id = choice_id
    self.correct = self.question_choice.correct
    self.save!
  end

  def update_learnt_words
    if self.correct
      self.user.learnt_word_maps.find_or_create_by(word_id: self.word_id)
    end
  end
end
