class CreateRevenues < ActiveRecord::Migration[5.2]
  def change
    create_table :revenues do |t|
      t.string :rev_type
      t.string :amount
      t.date :date
      t.integer :unit_id

      t.timestamps
    end
  end
end
