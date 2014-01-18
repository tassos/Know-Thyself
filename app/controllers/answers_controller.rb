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
    params[:answer][:Adjectives].uniq.each do |set|
      set.split(",").each do |word|
        case params[:answer][:LOA]
          when "High"
            Answer.find_or_create_by_Word(word.strip).increment!(:LOA_High)
          when "Medium"
            Answer.find_or_create_by_Word(word.strip).increment!(:LOA_Med)
          when "Low"
            Answer.find_or_create_by_Word(word.strip).increment!(:LOA_Low)
        end
        Answer.find_or_create_by_Word(word.strip).increment!(:Occur)
      end
    end
    redirect_to answers_path
  end
end