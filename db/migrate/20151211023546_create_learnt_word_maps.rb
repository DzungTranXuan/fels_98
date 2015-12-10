class CreateLearntWordMaps < ActiveRecord::Migration
  def change
    create_table :learnt_word_maps do |t|
      t.references :user, index: true, foreign_key: true
      t.references :word, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
