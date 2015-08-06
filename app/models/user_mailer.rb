class UserMailer < ActionMailer::Base
  default
  #require 'date'

  def private_message(email, full_name, message)
    @full_name = full_name
    @message = message
    @email = email
    @DTTM =  DateTime.now.in_time_zone("EST").strftime("%B %-d, %Y %I:%M%P")

    puts SettingUtility.settings['message_cc']
    mail(from: ENV['system_email_from'], to: ENV['feedback_email'], cc: SettingUtility.settings['message_cc'], bcc: ENV['feedback_email_bcc'], subject: "Syrup Website [#{full_name}]")
  end

end
