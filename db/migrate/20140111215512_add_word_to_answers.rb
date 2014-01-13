class AddWordToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :Word, :string
  end
end
