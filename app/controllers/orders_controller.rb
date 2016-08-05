class OrderController < ApplicationController

  def index
    @products = Product.order('position asc')

    render 'home/products'
  end

  def about
    @slide_show_items = SlideShowItem.order('position asc')
    @about_content = Content.find_by_name('about_image')
    render 'about'
  end

  def contact
    @message = Message.new

    @address = SettingUtility.setting('address')
    render 'contact'
  end

end
