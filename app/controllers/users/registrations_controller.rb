class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super do |resource|
      resource.uuid = SecureRandom.hex(n=4)
    end
  end
end
