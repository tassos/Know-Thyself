class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :survey
      t.string :adjectives
      t.integer :loa

      t.timestamps
    end
  end
end
