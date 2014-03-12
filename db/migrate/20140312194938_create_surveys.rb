class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :aid
      t.integer :user

      t.timestamps
    end
  end
end
