class AddDimensionsToSlideShowItem < ActiveRecord::Migration
  def change
    add_column :slide_show_items, :height_in_pixels, :integer
    add_column :slide_show_items, :width_in_pixels, :integer
  end
end
