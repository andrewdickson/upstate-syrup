class CreateZones < ActiveRecord::Migration
  def change
    add_column :products, :enabled, :boolean, default: true

    create_table :zones do |t|
      t.string :name
      t.string :box_a_cost
      t.string :box_b_cost
      t.text :states

      t.timestamps
    end

  end

end
