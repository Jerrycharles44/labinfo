class CreateWorkshops < ActiveRecord::Migration
  def change
        create_table :workshops do |t|
          t.string :name
          t.string :description
          t.string :icon
          t.integer :level
          t.integer :workshop_learder_id
        end
  end
end
