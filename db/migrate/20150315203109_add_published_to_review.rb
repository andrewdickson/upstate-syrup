class AddPublishedToReview < ActiveRecord::Migration
  def change
    add_column :reviews, :published, :boolean
  end
end
