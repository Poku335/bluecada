class CreateTypeStages < ActiveRecord::Migration[7.1]
  def change
    create_table :type_stages do |t|
      t.string :name
      t.string :code

      t.timestamps
    end
  end
end
