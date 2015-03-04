class SlideShowItem < ActiveRecord::Base
  acts_as_list

  attr_accessible :image
  has_attached_file :image
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  attr_accessible :alternate_text, :name, :user_id, :caption

  def self.max_height
    settings_file = YAML.load_file("#{Rails.root}/config/settings.yml")
    @settings = settings_file[Rails.env.to_s]

    return @settings['max-height']
  end


  def self.min_height
    settings_file = YAML.load_file("#{Rails.root}/config/settings.yml")
    @settings = settings_file[Rails.env.to_s]

    return @settings['min-height']
  end


  def self.max_width
    settings_file = YAML.load_file("#{Rails.root}/config/settings.yml")
    @settings = settings_file[Rails.env.to_s]

    return @settings['max-width']
  end


  def self.min_width
    settings_file = YAML.load_file("#{Rails.root}/config/settings.yml")
    @settings = settings_file[Rails.env.to_s]

    return @settings['min-width']
  end

end
