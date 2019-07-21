class CreateExpenses < ActiveRecord::Migration[5.2]
  def change
    create_table :expenses do |t|
      t.string :type
      t.string :amount
      t.date :date
      t.integer :unit_id

      t.timestamps
    end
  end
end
