class HomeController < ApplicationController

  def home
    @slide_show_items = SlideShowItem.order('position asc')
    puts @slide_show_items
    render 'home'
  end

  def about
    @slide_show_items = SlideShowItem.order('position asc')
    render 'about'
  end

  def contact
    @message = Message.new

    render 'contact'
  end

end
