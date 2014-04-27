class AddFieldToResponses < ActiveRecord::Migration
  def change
    change_table :responses do |t|
      t.integer :adjective_id
    end
  end
end
