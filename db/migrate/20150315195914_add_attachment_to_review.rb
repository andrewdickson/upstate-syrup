class AddAttachmentToReview < ActiveRecord::Migration

  def self.up
    add_attachment :reviews, :image
  end

  def self.down
    remove_attachment :reviews, :image
  end
end
