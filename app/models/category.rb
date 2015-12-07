class Category < ActiveRecord::Base
  has_many :lessons
  has_many :words

  paginates_per 10
end
