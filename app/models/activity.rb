class Activity < ActiveRecord::Base
  belongs_to :user

  class << self
    def add data
      activity = Activity.create({
        type_name:  data[:type],
        user_id:    data[:user_id],
        content:    data[:content]
      })
    end
  end
end
