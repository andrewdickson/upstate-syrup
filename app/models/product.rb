class Product < ActiveRecord::Base
  attr_accessible :description, :name, :price, :product_type, :shipping_price, :weight_in_ounces, :position, :image, :paypal_ship_code, :paypal_pickup_code, :shipping_option, :enabled

  acts_as_list
  has_attached_file :image, default_url: 'user-default-100.png'

  def image_path
    return image.url
  end
end
