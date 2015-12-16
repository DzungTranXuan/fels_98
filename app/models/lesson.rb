class Lesson < ActiveRecord::Base
  belongs_to :category
  belongs_to :user

  has_many :user_answers, dependent: :destroy

  before_save :create_questions

  def get_number_of_correct_answers
    self.user_answers.correct.count
  end

  private
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
end
