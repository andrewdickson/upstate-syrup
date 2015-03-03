class UserMailer < ActionMailer::Base
  default
  #require 'date'

  def private_message(email, full_name, message)
    @full_name = full_name
    @message = message
    @email = email
    @DTTM =  DateTime.now.in_time_zone("EST").strftime("%B %-d, %Y %I:%M%P")

    mail(from: 'upstatesyrup@gmail.com', to: 'upstatesyrup@gmail.com', subject: 'Message From Website')
  end

end
