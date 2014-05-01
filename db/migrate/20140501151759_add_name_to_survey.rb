class AddNameToSurvey < ActiveRecord::Migration
  def change
    change_table :surveys do |t|
      t.string :name
    end
  end
end
