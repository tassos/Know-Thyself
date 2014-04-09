class Response < ActiveRecord::Base
  belongs_to :survey
  has_many :adjectives, dependent: :destroy
end
