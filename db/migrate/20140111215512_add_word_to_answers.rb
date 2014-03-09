class AddWordToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :word, :string
  end
end
