class UserAnswer < ActiveRecord::Base
  belongs_to :user
  belongs_to :word
  belongs_to :question_choice
end
