class ResponsesController < ApplicationController
  def new
    @answers = Adjective.pluck(:word).sort
  end
  def create
    filtered=[]
    if params[:answer][:Adjectives].join.empty?
      flash[:notice]="Please select some Adjectives that describe me!"
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
          when "1" then Answer.find_or_create_by_word(word.strip).increment!(:loa_high)
          when "2" then Answer.find_or_create_by_word(word.strip).increment!(:loa_med)
          when "3" then Answer.find_or_create_by_word(word.strip).increment!(:loa_low)
          else raise 'Not supported value "#{params[:answer][:LOA]" for LOA(!?)'
        end
        Answer.find_or_create_by_word(word.strip).increment!(:occur)
      end
      flash[:notice]="Response submitted successfully!"
      respond_to do |format|
        format.html {redirect_to answers_path}
        format.js {render :action => 'success'}
      end
    end
  end
end