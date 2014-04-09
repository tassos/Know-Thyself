class Adjective < ActiveRecord::Base
  belongs_to :response, dependent: :destroy
end