class CreateTags < ActiveRecord::Migration[5.0]
  def change
    create_table :tags do |t|
      t.references :entity, polymorphic: true, index: true
      t.string :name
      t.timestamps
    end

    add_index :tags, :name
  end
end
