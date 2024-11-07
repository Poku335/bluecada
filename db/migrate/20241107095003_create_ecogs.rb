class CreateEcogs < ActiveRecord::Migration[7.1]
  def change
    create_table :ecogs do |t|
      t.string :name
      t.string :code

      t.timestamps
    end
  end
end
