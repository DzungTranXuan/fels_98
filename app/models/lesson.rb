class Lesson < ActiveRecord::Base
  belongs_to :category
  belongs_to :user

  has_many :user_answers

  before_save :create_questions


  def create_questions
    words = self.category.words.sample(self.number_of_questions)

    self.user_answers.build(
      words.map.with_index(1) do |word, i|
        {
          user_id:    self.user_id,
          word_id:    word.id,
          lesson_id:  self.id,
          order:      i
        }
      end
    )
  end

  def finish
    if self.get_number_of_correct_answers > 0
      Activity.add({
        type: "learn",
        user_id: self.user_id,
        content: I18n.t("activity.learnt_n_words_in_lesson_x", n: correct_num, x: self.category.name)
      })
    end
  end

  def get_number_of_correct_answers
    self.user_answers.where(correct: true).count
  end
end
