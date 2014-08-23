class WelcomeController < ApplicationController
  def index
    @address = Address.new
    if user_signed_in?
      @salutation = current_user.name
    else
      @salutation = 'guest'
    end
  end
end
