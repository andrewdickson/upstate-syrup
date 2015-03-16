class AddAttachmentToSlideShowItem < ActiveRecord::Migration

  def self.up
    add_attachment :slide_show_items, :image
  end

  def self.down
    remove_attachment :slide_show_items, :image
  end

end
