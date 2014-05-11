class SurveysController < ApplicationController
  before_filter :authenticate_user!
  def new
    @survey = Survey.new
    @response = Response.new
    @adjectives = Adjective.all.order(:word)
  end
  def create
    if params[:response][:Adjectives].empty?
      flash[:notice]="Please fill in some Adjectives that describe your friend!"
      respond_to do |format|
        format.html { redirect_to new_answer_path }
        format.js {render :action => 'failure'}
      end
    else
      @survey = Survey.new(user_id: current_user.id, name: params[:survey][:name], uuid: SecureRandom.base64(n=16))
      @survey.save
  
      @response = Response.new(survey_id: @survey.id, loa: '4', adjective_ids: params[:response][:Adjectives], uuid: SecureRandom.hex(n=5))
      @response.save
      
      redirect_to surveys_path
    end
  end
  def index
    @surveys=current_user.surveys
  end
  def show
    @survey = Survey.find(params[:id])
    @adjectives = Adjective.all
  end
end
