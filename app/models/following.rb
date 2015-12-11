class Following < ActiveRecord::Base
  belongs_to :follower, class_name: User
  belongs_to :user

  after_save ->{create_activity Activity::TYPES[:follow]}
  after_destroy ->{create_activity Activity::TYPES[:unfollow]}

  private
  def create_activity type
    Activity.add({
      type: type[:name],
      user_id: self.follower.id,
      content: type[:message].call(self.user.get_name)
    })
  end
end
