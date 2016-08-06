class HomeController < ApplicationController
  before_filter :set_products
  before_filter :set_slide_show_items

  def home
    render 'home'
  end

  def about
    @about_content = Content.find_by_name('about_image')
    render 'about'
  end

  def contact
    @message = Message.new
    @address = SettingUtility.setting('address')
    render 'contact'
  end

  def set_products
    @products = Product.where(enabled: true).order('position asc')
  end

  def set_slide_show_items
    @slide_show_items = SlideShowItem.order('position asc')
  end

end
