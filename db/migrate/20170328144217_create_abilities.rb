class CreateAbilities < ActiveRecord::Migration[5.1]
  def change
    create_table :abilities do |t|
      t.string :name
      t.jsonb :more
      t.integer :hero_id

      t.timestamps
    end
  end
end
