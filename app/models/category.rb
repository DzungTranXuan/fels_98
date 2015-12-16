class Category < ActiveRecord::Base
  has_many :lessons, dependent: :nullify
  has_many :words, dependent: :nullify

  validates :name, presence: true, length: {maximum: 50}

  has_attached_file :cover_photo,
    styles: {small: "32x20", med: "160x100", large: "320x200"},
    default_url: "/photos/categories/:style/missing.jpg"
  validates_attachment :cover_photo,
    content_type: {content_type: ["image/jpeg", "image/png"]},
    size: {in: 0..2000.kilobytes}

  paginates_per 10
end
