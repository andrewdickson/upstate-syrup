class Message < ActiveRecord::Base
  attr_accessible :email, :message, :name, :url


  def validate(params)
    self.filled_hidden_url = (self.url && self.url != "")
    self.has_link = self.message.downcase.include?('http')
    self.language = DetectLanguage.simple_detect(self.message)
    is_english = self.language == "en"
    self.spam = self.filled_hidden_url || self.has_link || !is_english || !self.message || self.message == ""
    return spam
  end
  
  def mark_spam
    self.message = "[SPAM] #{self.message}"
    self.name = "[SPAM] #{self.name}"
    self.message = "[#{self.language}] #{self.message}" if self.language != "en"
    name = "[#{self.language}] #{self.name}" if self.language != "en"
    message = "[#{self.url}] #{self.message}" if self.filled_hidden_url
  end

end