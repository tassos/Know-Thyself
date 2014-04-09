class Response < ActiveRecord::Base
  belongs_to :survey, dependent: :destroy
  has_many :adjectives
end
