class CreateChallenges < ActiveRecord::Migration[7.2]
  def change
    create_table :challenges do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.date :start_data, null: false
      t.date :end_data, null: false

      t.timestamps
    end
  end
end
