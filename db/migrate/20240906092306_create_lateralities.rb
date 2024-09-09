class CreateLateralities < ActiveRecord::Migration[7.1]
  def change
    create_table :lateralities do |t|
      t.integer :code
      t.string :name

      t.timestamps
    end
  end
end
