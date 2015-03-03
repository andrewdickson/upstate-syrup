class AddPositionToSlideShowItem < ActiveRecord::Migration
  def change
    add_column :slide_show_items, :position, :integer
  end
end
