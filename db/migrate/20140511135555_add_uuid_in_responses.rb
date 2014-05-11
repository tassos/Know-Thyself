class AddUuidInResponses < ActiveRecord::Migration
  def change
    change_table :responses do |t|
      t.string :uuid
    end
  end
end
