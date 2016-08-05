class AddShippingOptionToProduct < ActiveRecord::Migration
  def change
    add_column :products, :shipping_option, :string
  end
end
