class DropSelfResponsesTable < ActiveRecord::Migration
  def change
    drop_table :self_responses
  end
end
