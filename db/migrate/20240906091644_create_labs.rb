class CreateLabs < ActiveRecord::Migration[7.1]
  def change
    create_table :labs do |t|
      t.integer :code
      t.string :name

      t.timestamps
    end
  end
end
