class Adjective < ActiveRecord::Base
  has_and_belongs_to_many :responses
  has_and_belongs_to_many :self_responses
end