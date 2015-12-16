class AddAttachmentCoverPhotoToCategories < ActiveRecord::Migration
  def change
    remove_column :categories, :cover_photo
    add_attachment :categories, :cover_photo
  end
end
