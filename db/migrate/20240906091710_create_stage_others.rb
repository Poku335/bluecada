class CreateStageOthers < ActiveRecord::Migration[7.1]
  def change
    create_table :stage_others do |t|
      t.integer :code
      t.string :name

      t.timestamps
    end
  end
end
