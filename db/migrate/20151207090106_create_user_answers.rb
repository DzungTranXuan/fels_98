class CreateUserAnswers < ActiveRecord::Migration
  def change
    create_table :user_answers do |t|
      t.references :user, index: true, foreign_key: true
      t.references :word, index: true, foreign_key: true
      t.references :lesson, index: true, foreign_key: true
      t.references :question_choice, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
