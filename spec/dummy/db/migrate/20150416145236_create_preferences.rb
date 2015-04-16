class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.integer :user_id
      t.string :language
      t.boolean :notifications

      t.timestamps null: false
    end
  end
end
