class AlterSlideShowItem < ActiveRecord::Migration
  def up
    remove_column :slide_show_items, :paperclip_id
    remove_column :slide_show_items, :path

    add_column :slide_show_items, :caption, :string
  end

end
