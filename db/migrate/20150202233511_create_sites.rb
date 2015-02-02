class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :name
      t.string :base_url
      t.string :subdomain
      t.string :phone
      t.string :email
      t.string :address1
      t.string :address2
      t.string :address3
      t.string :owner
      t.string :company
      t.string :copyright
      t.integer :template_id

      t.timestamps
    end
  end
end
