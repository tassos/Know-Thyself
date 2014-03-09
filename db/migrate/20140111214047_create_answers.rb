class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :occur
      t.integer :loa_low
      t.integer :loa_med
      t.integer :loa_high

      t.timestamps
    end
  end
end
