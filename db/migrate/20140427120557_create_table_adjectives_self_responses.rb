class CreateTableAdjectivesSelfResponses < ActiveRecord::Migration
  def change
    create_table :adjectives_self_responses, id: false do |t|
      t.belongs_to :adjective
      t.belongs_to :self_response
    end
  end
end
