class AdjectivesController < ApplicationController
  before_filter :authenticate_admin!, :only => [:index]
  
  def index
    @adjectives = Adjective.where(visibility:1).pluck(:word).sort
  end
  
  def create
    Adjective.update(params[:answer][:toRemove],0)    
    Adjective.update(params[:answer][:toAdd],1)
    redirect_to adjectives_path
  end
  
end
