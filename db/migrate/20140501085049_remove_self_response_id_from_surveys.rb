class RemoveSelfResponseIdFromSurveys < ActiveRecord::Migration
  def change
    change_table :surveys do |t|
      t.remove :self_response_id
    end
  end
end
