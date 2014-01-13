class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :Occur
      t.integer :LOA_Low
      t.integer :LOA_Med
      t.integer :LOA_High

      t.timestamps
    end
  end
end
