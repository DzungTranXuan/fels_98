class AddPronunciationAttachmentToWords < ActiveRecord::Migration
  def change
    remove_column :words, :pronunciation_file
    add_attachment :words, :pronunciation
  end
end
