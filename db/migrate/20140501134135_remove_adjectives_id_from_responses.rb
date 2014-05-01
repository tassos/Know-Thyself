class RemoveAdjectivesIdFromResponses < ActiveRecord::Migration
  def change
    change_table :responses do |t|
      t.remove :adjective_id
    end
  end
end
