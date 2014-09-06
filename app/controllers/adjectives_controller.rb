class AdjectivesController < ApplicationController
  before_filter :authenticate_admin!, :only => [:index]
  
  def index
    @adjectives = Adjective.where(visibility:1).pluck(:word).sort
  end
  
  def create
    unless params[:answer][:toRemove].nil?
      params[:answer][:toRemove].uniq.each do |word|
        @adjective=Adjective.find_by_word(word.downcase)
        @adjective.visibility = 0
        @adjective.save
      end
    end
    
    unless params[:answer][:toAdd].nil?
      params[:answer][:toAdd][0].split( /, */ ).uniq.each do |word|
        Adjective.find_or_create_by_word(word.downcase)
        @adjective=Adjective.find_by_word(word.downcase)
        @adjective.visibility = 1
        @adjective.save
      end
    end
  redirect_to adjectives_path
  end
end
