class UserMailer < ActionMailer::Base
  default
  #require 'date'

  def private_message(email, full_name, message, ccEmail)
    @full_name = full_name
    @message = message
    @email = email
    @DTTM =  DateTime.now.in_time_zone("EST").strftime("%B %-d, %Y %I:%M%P")

    Rails.logger.debug("CC Email: [#{ccEmail}]")
    mail(from: ENV['system_email_from'], to: ENV['feedback_email'], cc: ccEmail, bcc: ENV['feedback_email_bcc'], subject: "Syrup Website [#{full_name}]")
  end

end
