class AddUuidFieldOnUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :uuid
    end
  end
end
