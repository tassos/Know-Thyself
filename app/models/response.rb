class Response < ActiveRecord::Base
  belongs_to :survey
  has_and_belongs_to_many :adjectives
  validates :uuid, :uniqueness => {:scope => :survey_id}
end
