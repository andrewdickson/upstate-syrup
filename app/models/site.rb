class Site < ActiveRecord::Base
  attr_accessible :address1, :address2, :address3, :base_url, :company, :copyright, :email, :name, :owner, :phone, :subdomain, :template_id
end
