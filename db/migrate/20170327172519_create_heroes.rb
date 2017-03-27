class CreateHeroes < ActiveRecord::Migration[5.1]
  def change
    create_table :heroes do |t|
      t.string :name
      t.string :profile_url
      t.integer :base_str
      t.integer :base_agi
      t.integer :base_int
      t.float :add_str
      t.float :add_agi
      t.float :add_int
      t.integer :move_speed
      t.float :turn_rate
      t.string :attack_type
      t.jsonb :talents
      t.integer :attack_range
      t.string :hero_type

      t.timestamps
    end
  end
end
