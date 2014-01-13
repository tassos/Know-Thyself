class AnswersController < ApplicationController
  def new
    @answers = Answer.all
  end
  def index
    @answers = Answer.all
  end
  def show
  end
  def create
      case params[:post][:LOA]
      when "High"
        Answer.find_or_create_by_Word(params[:post][:Adjectives]).increment!(:LOA_High)
      when "Medium"
        Answer.find_or_create_by_Word(params[:post][:Adjectives]).increment!(:LOA_Med)
      when "Low"
        Answer.find_or_create_by_Word(params[:post][:Adjectives]).increment!(:LOA_Low)
      end
    Answer.find_or_create_by_Word(params[:post][:Adjectives]).increment!(:Occur)
    redirect_to answers_path
  end
end
