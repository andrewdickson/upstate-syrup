class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.text :comment
      t.string :name
      t.integer :position

      t.timestamps
    end
  end
end
