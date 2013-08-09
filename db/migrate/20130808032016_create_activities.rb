class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.datetime :date

      t.timestamps
    end
    add_reference :activities, :activity_type, index: true
    add_reference :activities, :user, index: true
  end
end
