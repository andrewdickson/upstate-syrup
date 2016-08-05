class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.float :price
      t.string :product_type
      t.float :weight_in_ounces
      t.float :shipping_price
      t.text :description
      t.text :paypal_ship_code
      t.text :paypal_pickup_code
      t.integer :position

      t.timestamps
    end

    add_attachment :products, :image
  end
end
