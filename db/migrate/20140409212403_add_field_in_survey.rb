class AddFieldInSurvey < ActiveRecord::Migration
  def change
    change_table :surveys do |t|
      t.integer :self_response_id
    end
  end
end
