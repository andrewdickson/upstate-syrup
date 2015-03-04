class SlideShowItem < ActiveRecord::Base
  acts_as_list

  attr_accessible :image
  has_attached_file :image
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  attr_accessible :alternate_text, :name, :user_id, :caption, :dimensions

# Retrieves dimensions for image assets
# @note Do this after resize operations to account for auto-orientation.
  def extract_dimensions
    tempfile = image.queued_for_write[:original]
    unless tempfile.nil?
      geometry = Paperclip::Geometry.from_file(tempfile)
      width = geometry.width.to_i
      height = geometry.height.to_i

      self.width_in_pixels, self.height_in_pixels = resize(width,height)
      #puts "#{geometry.width.to_i}x#{geometry.height.to_i} => #{self.width_in_pixels}x#{self.height_in_pixels}"
      require 'ImageResize'
      Image.resize(tempfile.path, tempfile.path, self.width_in_pixels, self.height_in_pixels)

      geometry = Paperclip::Geometry.from_file(tempfile)
      puts geometry.width.to_s
    end
  end

  def resize(width,height)
    max_height = SettingUtility.max_height.to_i
    max_width = SettingUtility.max_width.to_i
    min_height = SettingUtility.min_height.to_i
    min_width = SettingUtility.min_width.to_i

    if width > max_width
      height = height * max_width / width
      width = max_width
    end

    if width < min_width
      height = height * min_width / width
      width = min_width
    end

    if height > max_height
      width = width * max_height/height
      height = max_height
    end

    if height < min_height
      width = width * min_height/height
      width = min_width
    end

    return [width, height]
  end

end
