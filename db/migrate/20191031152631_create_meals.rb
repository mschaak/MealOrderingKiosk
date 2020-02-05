class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.string 'meal_name'
      t.integer 'meal_calories'
      t.boolean 'monday'
      t.boolean 'tuesday'
      t.boolean 'wednesday'
      t.boolean 'thursday'
      t.boolean 'friday'
      t.boolean 'saturday'
      t.boolean 'sunday'
      t.timestamps null: false
      t.string  :dietary_restrictions, null: false, default: ""
      t.text :description, null: false, default: ""
    end
    add_index :meals, 'meal_name',                unique: true
  end
end
