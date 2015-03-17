class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :name
      t.text :content

      t.timestamps
    end

    add_attachment :contents, :image
  end
end
