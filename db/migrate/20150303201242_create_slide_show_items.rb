class CreateSlideShowItems < ActiveRecord::Migration
  def change
    create_table :slide_show_items do |t|
      t.string :name
      t.string :alternate_text
      t.string :path
      t.integer :paperclip_id
      t.integer :user_id

      t.timestamps
    end
  end
end
