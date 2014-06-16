class Address < ActiveRecord::Base
  validates :email, uniqueness: true
end
