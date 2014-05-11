class AddUuidInSurveys < ActiveRecord::Migration
  def change
    change_table :surveys do |t|
      t.string :uuid
    end
  end
end
