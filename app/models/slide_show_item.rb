class SlideShowItem < ActiveRecord::Base
  attr_accessible :image
  has_attached_file :image
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  attr_accessible :alternate_text, :name, :user_id, :caption

end
