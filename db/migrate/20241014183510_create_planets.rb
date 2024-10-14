class CreatePlanets < ActiveRecord::Migration[7.2]
  def change
    create_table :planets do |t|
      t.text :name
      t.integer :population

      t.timestamps
    end
    add_index :planets, :name, unique: true
  end
end
