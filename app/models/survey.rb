class Survey < ActiveRecord::Base
  belongs_to :user
  has_many :responses, dependent: :destroy
end
