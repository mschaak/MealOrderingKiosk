class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :student, foreign_key: true
      t.references :meal, foreign_key: true
      t.boolean 'complete'
      t.timestamps null: false
    end
  end
end
