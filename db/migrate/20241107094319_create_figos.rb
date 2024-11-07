class CreateFigos < ActiveRecord::Migration[7.1]
  def change
    create_table :figos do |t|
      t.string :name
      t.string :code

      t.timestamps
    end
  end
end
