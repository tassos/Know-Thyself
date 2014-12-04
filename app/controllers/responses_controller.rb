class ResponsesController < ApplicationController
  def new
    @survey = Survey.find_by_uuid(params[:id])
    @response = Response.new
    @adjectives = Adjective.where(visibility:1).shuffle
  end
  def create
    if (params[:response][:Adjectives].nil? && params[:response][:newAdjectives] == [""])
      flash[:alert]="Please select some adjectives that describe your friend!"
      respond_to do |format|
        format.html { redirect_to new_survey_response_path(params[:response][:survey_uuid])}
      end
    else
      ids = Adjective.update(params[:response][:newAdjectives],0)
      if !params[:response][:Adjectives].nil?
        params[:response][:Adjectives].each {|s| ids << s.to_i}
      end
      @response = Response.new(survey_id: params[:response][:survey_id], loa: params[:response][:loa], adjective_ids: ids.uniq, uuid: SecureRandom.hex(n=5))
      @response.save
      
      flash[:notice]="Response sent successfully!"
      if user_signed_in?
        redirect_to survey_path(@response.survey.uuid)
      else
        redirect_to thanks_path
      end
    end
  end
  def show
    @response = Response.find_by_uuid(params[:id])
    @map = ["very close friend","good friend","friend/colleague","acquaintance"];
  end
end