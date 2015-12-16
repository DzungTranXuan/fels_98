class Activity < ActiveRecord::Base
  belongs_to :user

  TYPES = {
    learn: {
      id: 1,
      name: "learn",
      message: -> (correct_num, category_name) {
        I18n.t("activity.learnt_n_words_in_lesson_x", n: correct_num, x: category_name)
      }
    },
    follow: {
      id: 1,
      name: "follow",
      message: -> (user_id) {
        I18n.t("activity.follow_x", x: user_id)
      }
    },
    unfollow: {
      id: 1,
      name: "unfollow",
      message: -> (user_id) {
        I18n.t("activity.unfollow_x", x: user_id)
      }
    }
  }

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
