class UserAnswer < ActiveRecord::Base
  belongs_to :user
  belongs_to :word
  belongs_to :question_choice
  belongs_to :lesson

  scope :correct, ->{where correct: true}

  def submit choice_id
    self.question_choice_id = choice_id
    self.correct = self.question_choice.correct
    self.save!

    create_activity if self.is_last_question?
    # update_learnt_words
  end

  def is_last_question?
    self.order < self.lesson.number_of_questions
  end


  private
  # def update_learnt_words
  #   if self.correct
  #     self.user.learnt_word_maps.find_or_create_by(word_id: self.word_id)
  #   end
  # end

  def create_activity
    correct_num = self.lesson.get_number_of_correct_answers

    if correct_num > 0
      activity_type = Activity::TYPES[:learn]

      Activity.add({
        type:     activity_type[:name],
        user_id:  self.user_id,
        content:  activity_type[:message].call(correct_num, self.lesson.category.name)
      })
    end

    self
  end
end
