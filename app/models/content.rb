class Content < ActiveRecord::Base
  attr_accessible :content, :name, :image

  has_attached_file :image
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

end
