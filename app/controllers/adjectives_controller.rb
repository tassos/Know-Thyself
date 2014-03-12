class AdjectivesController < ApplicationController
  def index
  end
  def create
    unless params[:answer][:toRemove].nil?
      params[:answer][:toRemove].uniq.each do |word|
        @adjective=Adjectives.find_by_word(word.downcase)
        @adjective.destroy
      end
    end
    
    unless params[:answer][:toAdd].nil?
      params[:answer][:toAdd][0].split( /, */ ).uniq.each do |word|
        Adjectives.find_or_create_by_word(word.downcase)
      end
    end
  redirect_to admin_index_path
  end
end
