class CreatePostneoStagings < ActiveRecord::Migration[7.1]
  def change
    create_table :postneo_stagings do |t|
      t.string :name
      t.string :code

      t.timestamps
    end
  end
end
