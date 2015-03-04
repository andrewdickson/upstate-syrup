class SettingUtility

  def self.settings
    settings_file = YAML.load_file("#{Rails.root}/config/settings.yml")
    return settings_file[Rails.env.to_s]
  end

  def self.max_height
    return SettingUtility.settings['max-height']
  end

  def self.min_height
    return SettingUtility.settings['min-height']
  end

  def self.max_width
    return SettingUtility.settings['max-width']
  end

  def self.min_width
    return SettingUtility.settings['min-width']
  end

  def self.SaveSettings(new_settings)
    File.open("#{Rails.root}/config/settings.yml", 'w') {|f| f.write new_settings.to_yaml }
  end

end