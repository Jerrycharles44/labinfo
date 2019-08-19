class CreateUserWorkshops < ActiveRecord::Migration
  def change
    create_table :user_workshops do |t|
      t.integer :confirmation, :default => 0
      t.string :notes
      t.integer :user_id
      t.integer :workshop_id
    end
  end
end
