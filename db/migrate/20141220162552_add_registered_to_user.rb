class AddRegisteredToUser < ActiveRecord::Migration
  def change
    add_column :users, :registered, :boolean
  end
end
