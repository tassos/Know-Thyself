class ResponsesController < ApplicationController
  def new
    @survey = Survey.find_by_uuid(params[:id])
    @response = Response.new
    @adjectives = Adjective.where(visibility:1).order(:word)
  end
  def create
    if params[:response][:Adjectives].nil? || !params[:response][:loa].in?([1,2,3])
      flash[:notice]="Please select some adjectives that describe your friend and select the level of acquaintance!"
      respond_to do |format|
        format.html { redirect_to new_survey_response_path(params[:response][:survey_uuid])}
        format.js {render :action => 'failure'}
      end
    else
      @response = Response.new(survey_id: params[:response][:survey_id], loa: params[:response][:loa], adjective_ids: params[:response][:Adjectives], uuid: SecureRandom.hex(n=5))
      @response.save
      
      if user_signed_in?
        redirect_to survey_path(@response.survey.uuid)
      else
        redirect_to root
      end
    end
  end
  def show
    @response = Response.find_by_uuid(params[:id])
    @map = ["","very good","somehow","a little bit"];
  end
end