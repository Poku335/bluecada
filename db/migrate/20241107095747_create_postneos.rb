class CreatePostneos < ActiveRecord::Migration[7.1]
  def change
    create_table :postneos do |t|
      t.string :name
      t.string :code

      t.timestamps
    end
  end
end
