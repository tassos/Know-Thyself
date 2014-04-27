class CreateSelfResponses < ActiveRecord::Migration
  def change
    create_table :self_responses do |t|

      t.timestamps
      t.integer :survey_id
      t.integer :adjective_id
    end
  end
end
