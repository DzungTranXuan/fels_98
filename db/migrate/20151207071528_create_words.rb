class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.references :category, index: true, foreign_key: true

      t.string :text
      t.string :meaning
      t.string :pronunciation_file

      t.timestamps null: false
    end
  end
end
