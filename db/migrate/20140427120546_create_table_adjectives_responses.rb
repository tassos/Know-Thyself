class CreateTableAdjectivesResponses < ActiveRecord::Migration
  def change
    create_table :adjectives_responses, id: false do |t|
      t.belongs_to :adjective
      t.belongs_to :response
    end
  end
end
