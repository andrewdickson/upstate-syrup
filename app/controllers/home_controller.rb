class HomeController < ApplicationController

  def home
    @slide_show_items = SlideShowItem.order('position asc')
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

  def create_message
    message = Message.new(params[:message])

    if message.save
      ret = UserMailer.private_message(message.email, message.name, message.message)
      ret.deliver
    end
    render 'sent'
  end

end
