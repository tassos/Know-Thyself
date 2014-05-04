class ResponsesController < ApplicationController
  def new
    @survey = Survey.find(params[:id])
    @response = Response.new
    @adjectives = Adjective.all.order(:word)
  end
  def create
    if params[:response][:Adjectives].empty?
      flash[:notice]="Please fill in some Adjectives that describe me!"
      respond_to do |format|
        format.html { redirect_to new_answer_path }
        format.js {render :action => 'failure'}
      end
    else
      @response = Response.new(survey_id: params[:response][:survey_id], loa: params[:response][:loa], adjective_ids: params[:response][:Adjectives])
      @response.save
      
      redirect_to surveys_path
    end
  end
  def show
    @response = Response.find(params[:id])
  end
end