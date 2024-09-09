class CreateCancerFormStatuses < ActiveRecord::Migration[7.1]
  def change
    create_table :cancer_form_statuses do |t|
      t.string :name

      t.timestamps
    end
  end
end
