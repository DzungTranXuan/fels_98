class AddCorrectUserAnswer < ActiveRecord::Migration
  def change
    add_column :user_answers, :correct, :boolean, default: false
  end
end
