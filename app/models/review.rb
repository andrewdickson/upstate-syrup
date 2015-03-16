class Review < ActiveRecord::Base
  acts_as_list

  attr_accessible :comment, :name, :rating, :position

  attr_accessible :image
  has_attached_file :image, default_url: 'user-default-100.png'
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  attr_accessible :alternate_text, :name, :user_id, :caption, :dimensions

  def image_path
    return image.url
  end
end
