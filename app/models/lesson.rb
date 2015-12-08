class Lesson < ActiveRecord::Base
  belongs_to :category
  belongs_to :user

  has_many :user_answers
end
