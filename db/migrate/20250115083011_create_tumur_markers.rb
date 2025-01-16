class CreateTumurMarkers < ActiveRecord::Migration[7.1]
  def change
    create_table :tumur_markers do |t|
      t.integer :code
      t.string :name

      t.timestamps
    end
  end
end
