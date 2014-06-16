class AddressesController < ApplicationController
  def create
    @address = Address.new(email: params[:address][:email])
    if @address.valid?
      @address.save
      flash[:notice]="Thank you for subscribing to the newsletter!"
    else
      flash[:warning]="You are already subscribed to the newsletter."
    end
     
    redirect_to root_path
  end
end
