class CreateDailies < ActiveRecord::Migration
  def change
    create_table :dailies do |t|

      t.timestamps null: false
    end
  end
end
