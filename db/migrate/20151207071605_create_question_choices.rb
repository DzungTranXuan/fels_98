class CreateQuestionChoices < ActiveRecord::Migration
  def change
    create_table :question_choices do |t|
      t.references :word, index: true, foreign_key: true

      t.string :text
      t.boolean :correct

      t.timestamps null: false
    end
  end
end
