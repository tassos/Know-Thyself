class AnswersController < ApplicationController
  def new
    @answers = Answer.pluck(:word)
  end
  def index
    @answers = Answer.all
  end
  def show
  end
  def create
    words = params[:post][:Adjectives].split(",")
    words.each do |word|
      case params[:post][:LOA]
        when "High"
          Answer.find_or_create_by_Word(word.strip).increment!(:LOA_High)
        when "Medium"
          Answer.find_or_create_by_Word(word.strip).increment!(:LOA_Med)
        when "Low"
          Answer.find_or_create_by_Word(word.strip).increment!(:LOA_Low)
      end
      Answer.find_or_create_by_Word(word.strip).increment!(:Occur)
    end
    redirect_to answers_path
  end
end