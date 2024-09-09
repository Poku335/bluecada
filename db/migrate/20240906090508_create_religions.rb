class CreateReligions < ActiveRecord::Migration[7.1]
  def change
    create_table :religions do |t|
      t.integer :code
      t.string :name

      t.timestamps
    end
  end
end
