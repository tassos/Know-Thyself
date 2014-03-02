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
    if params[:answer][:Adjectives].join.empty?
      flash[:notice]="Please fill in some Adjectives that describe me!"
      respond_to do |format|
        format.html { redirect_to new_answer_path }
        format.js {render :action => 'failure'}
      end
    elsif params[:answer][:LOA].empty?
      flash[:notice]="Please fill in the Level of our Acquaintance :)"
      respond_to do |format|
        format.html { redirect_to new_answer_path }
        format.js {render :action => 'failure'}
      end
    else
      params[:answer][:Adjectives].each do |words|
        words.split( /, */ ).uniq.each do |word|
          filtered << word.downcase
        end
      end
  
      filtered.uniq.each do |word|
        case params[:answer][:LOA]
          when "1" then Answer.find_or_create_by_Word(word.strip).increment!(:LOA_High)
          when "2" then Answer.find_or_create_by_Word(word.strip).increment!(:LOA_Med)
          when "3" then Answer.find_or_create_by_Word(word.strip).increment!(:LOA_Low)
          else raise 'Not supported value "#{params[:answer][:LOA]" for LOA(!?)'
        end
        Answer.find_or_create_by_Word(word.strip).increment!(:Occur)
      end
      flash[:notice]="Response submitted successfully!"
      respond_to do |format|
        format.html {redirect_to answers_path}
        format.js {render :action => 'success'}
      end
    end
  end
end