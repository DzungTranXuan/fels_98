class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :lessons
  has_many :user_answers
  has_many :activities

  has_many :learnt_word_maps
  has_many :learnt_words, through: :learnt_word_maps, source: :word

  has_many :following_others, class_name: Following, foreign_key: :follower_id
  has_many :followed_by_others, class_name: Following, foreign_key: :followed_user_id

  has_many :followers, through: :followed_by_others
  has_many :followed_users, through: :following_others

  validates :name, length: {maximum: 20}

  has_attached_file :avatar,
    styles: {small: "32x32", med: "100x100", large: "200x200"},
    default_url: "/photos/avatars/:style/missing.png"
  validates_attachment :avatar,
    content_type: {content_type: ["image/jpeg", "image/png"]},
    size: {in: 0..2000.kilobytes}

  paginates_per 10


  def get_activities
    self.activities.last(10).reverse
  end

  def get_number_of_words_learnt
    self.learnt_word_maps.count
  end

  def get_following_activities limit = nil
    self.followed_users
      .preload(:activities)
      .inject([]) {|sum, i| sum += i.activities}
      .sort_by {|activity| activity.id}
      .reverse
      .first(20)
  end

  def follow user_id
    if self.following_others.create({followed_user_id: user_id})
      Activity.add({
        type: "Follow",
        user_id: self.id,
        content: I18n.t("activity.follow_x", x: User.find(user_id).get_name)
      })
      return true
    else
      return false
    end
  end

  def unfollow user_id
    if self.following_others.find_by(followed_user_id: user_id).destroy
      Activity.add({
        type: "Unfollow",
        user_id: self.id,
        content: I18n.t("activity.unfollow_x", x: User.find(user_id).get_name)
      })
      return true
    else
      return false
    end
  end

  def following? user_id
    self.following_others.exists? followed_user_id: user_id
  end

  def get_name
    return self.name if self.name.present?

    i = self.email.index("@")
    i.present? ? self.email[0, i] : self.email
  end
end
