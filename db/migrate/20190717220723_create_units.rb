class CreateUnits < ActiveRecord::Migration[5.2]
  def change
    create_table :units do |t|
      t.string :apt_num
      t.string :tenant
      t.integer :building_id
      t.integer :user_id

      t.timestamps
    end
  end
end
