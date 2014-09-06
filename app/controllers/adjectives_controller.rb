class AdjectivesController < ApplicationController
  before_filter :authenticate_admin!, :only => [:index]
  
  def index
    @adjectives = Adjective.where(visibility:1).pluck(:word).sort
  end
  
  def create
    update(params[:answer][:toRemove],0)    
    update(params[:answer][:toAdd],1)
    redirect_to adjectives_path
  end
  
  private
  def update(parameters,visibility)
    unless parameters.nil?
      parameters[0].split( /, */ ).uniq.each do |word|
        Adjective.find_or_create_by_word(word.downcase)
        @adjective=Adjective.find_by_word(word.downcase)
        @adjective.visibility = visibility
        @adjective.save
      end
    end
  end
end
