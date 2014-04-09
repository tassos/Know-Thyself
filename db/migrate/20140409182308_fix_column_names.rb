class FixColumnNames < ActiveRecord::Migration
  def change
    change_table :surveys do |t|
      t.rename :user, :user_id
    end
    
    change_table :responses do |t|
      t.rename :survey, :survey_id
      t.remove :adjectives
    end
    
    change_table :adjectives do |t|
      t.integer :response_id
    end
  end
end
