class RemoveFieldFromSurveys < ActiveRecord::Migration
  def change
    change_table :surveys do |t|
      t.remove :aid
    end
  end
end
