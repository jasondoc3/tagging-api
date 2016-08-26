class CreateCars < ActiveRecord::Migration[5.0]
  def change
    create_table :cars do |t|
      t.string :model
      t.string :brand
      t.integer :year
      t.integer :miles

      t.timestamps
    end
  end
end
