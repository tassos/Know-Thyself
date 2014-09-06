class AddressesController < ApplicationController
  before_filter :authenticate_admin!, only: :index
  
  def create
    if params[:add_button]
      @address = Address.new(email: params[:address][:email])
      if @address.valid?
        @address.save
        flash[:notice]="Thank you for subscribing to the newsletter!"
      else
        flash[:warning]="You are already subscribed to the newsletter."
      end
    elsif params[:remove_button]
      @address = Address.find_by_email(params[:address][:email])
      if @address.nil?
        flash[:warning]="This e-mail address was not registered in this newletter."
      else
        @address.destroy
        flash[:notice]="You are now unsubscribed from the newsletter."
      end
    end
     
    redirect_to root_path
  end
  
  def index
    @addresses = Address.all
  end
end
