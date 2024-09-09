class CreateMaritalStatuses < ActiveRecord::Migration[7.1]
  def change
    create_table :marital_statuses do |t|
      t.integer :code
      t.string :name

      t.timestamps
    end
  end
end
