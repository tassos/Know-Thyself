class Survey < ActiveRecord::Base
  belongs_to :user
  has_many :responses, dependent: :destroy
  has_one :self_response, dependent: :destroy
end
