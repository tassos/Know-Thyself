class AddVisibilityToAdjectives < ActiveRecord::Migration
  def change
    change_table :adjectives do |t|
      t.integer :visibility
    end
  end
end
