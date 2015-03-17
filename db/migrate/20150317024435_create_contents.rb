class CreateContents < ActiveRecord::Migration
  def up
    create_table :contents do |t|
      t.string :name
      t.text :content

      t.timestamps
    end

    add_attachment :contents, :image
  end

  def down
    drop_table :contents
    remove_attachment :contents, :image
  end
end
