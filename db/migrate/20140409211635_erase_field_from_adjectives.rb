class EraseFieldFromAdjectives < ActiveRecord::Migration
  def change
    
   change_table :adjectives do |t|
     t.remove :response_id
   end
  end
end
