class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :lessons, dependent: :destroy
  has_many :user_answers, dependent: :destroy
  has_many :activities, dependent: :destroy

  has_many :learnt_word_maps, dependent: :destroy
  has_many :learnt_words, through: :learnt_word_maps, source: :word, dependent: :destroy

  has_many :following_others, class_name: Following, foreign_key: :follower_id, dependent: :destroy
  has_many :followed_by_others, class_name: Following, foreign_key: :user_id, dependent: :destroy

  has_many :followers, through: :followed_by_others
  has_many :followed_users, through: :following_others, source: :user

  validates :name, length: {maximum: 20}

  has_attached_file :avatar,
    styles: {small: "32x32", med: "100x100", large: "200x200"},
    default_url: "/photos/avatars/:style/missing.png"
  validates_attachment :avatar,
    content_type: {content_type: ["image/jpeg", "image/png"]},
    size: {in: 0..2000.kilobytes}

  paginates_per 10

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

  def get_activities
    self.activities.order(id: :DESC).limit(20)
  end

  def following? user_id
    self.following_others.exists? user_id: user_id
  end

  def get_following_id user_id
    self.following_others.find_by(user_id: user_id).try(:id)
  end

  def get_name
    return self.name if self.name.present?

    i = self.email.index("@")
    i.present? ? self.email[0, i] : self.email
  end
end
