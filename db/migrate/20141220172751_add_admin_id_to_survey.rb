class AddAdminIdToSurvey < ActiveRecord::Migration
  def change
    add_column :surveys, :adminid, :string
  end
end
