class CreateFollowings < ActiveRecord::Migration
  def change
    create_table :followings do |t|
      t.timestamps null: false
    end

    add_reference :followings, :follower, references: :users, index: true
    add_reference :followings, :followed_user, references: :users, index: true
  end
end
