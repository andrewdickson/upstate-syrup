class SettingUtility

  def self.settings
    settings_file = YAML.load_file("#{Rails.root}/config/settings.yml")
    return settings_file[Rails.env.to_s]
  end

  def self.brand
    return SettingUtility.settings['brand']
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

  def self.about_heading
    return SettingUtility.settings['about_heading']
  end

  def self.about_p
    return SettingUtility.settings['about_p']
  end

  def self.home_heading
    return SettingUtility.settings['home_heading']
  end

  def self.home_p
    return SettingUtility.settings['home_p']
  end

  def self.setting(key)
    return SettingUtility.settings[key]
  end


  def self.SaveSettings(new_settings)
    settings_file = YAML.load_file("#{Rails.root}/config/settings.yml")
    settings_file[Rails.env] = new_settings
    File.open("#{Rails.root}/config/settings.yml", 'w') {|f| f.write settings_file.to_yaml }
  end

end