class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :name
      t.string :base_url
      t.string :email
      t.string :phone
      t.string :address
      t.string :address2
      t.string :address3

      t.timestamps
    end
  end
end
