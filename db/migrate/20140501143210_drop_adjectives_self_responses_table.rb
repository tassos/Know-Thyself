class DropAdjectivesSelfResponsesTable < ActiveRecord::Migration
  def change
    drop_table :adjectives_self_responses
  end
end
