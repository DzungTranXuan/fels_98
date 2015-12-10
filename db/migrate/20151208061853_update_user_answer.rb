class UpdateUserAnswer < ActiveRecord::Migration
  def change
    add_column :user_answers, :order, :integer
  end
end
