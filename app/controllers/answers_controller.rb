class AnswersController < ApplicationController
  def new
    @answers = Answer.pluck(:word).sort
  end
  def index
    @answers = Answer.all.order(:word)
  end
  def show
  end
  def create
    filtered=[]
    params[:answer][:Adjectives].each do |words|
      words.split( /, */ ).uniq.each do |word|
        puts filtered << word.downcase
      end
    end
        
    filtered.uniq.each do |word| 
      case params[:answer][:LOA]
        when "1"
          Answer.find_or_create_by_Word(word.strip).increment!(:LOA_High)
        when "2"
          Answer.find_or_create_by_Word(word.strip).increment!(:LOA_Med)
        when "3"
          Answer.find_or_create_by_Word(word.strip).increment!(:LOA_Low)
      end
      Answer.find_or_create_by_Word(word.strip).increment!(:Occur)
    end
    redirect_to answers_path
  end
end