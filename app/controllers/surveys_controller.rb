class SurveysController < ApplicationController
  before_filter :authenticate_user!
  before_filter :user_owns_survey?, :only => [:show, :destroy]
  def new
    @survey = Survey.new
    @response = Response.new
    @adjectives = Adjective.where(visibility:1).order(:word)
  end
  def create
    if params[:response].nil? || params[:survey][:name].empty?
      if params[:response].nil?
        flash[:alert]="Please select some adjectives that describe you!"
      else
        flash[:alert]="Please enter a description for your survey!"
      end
      respond_to do |format|
        format.html { redirect_to new_survey_path }
      end
    else
      @survey = Survey.new(user_id: current_user.id, name: params[:survey][:name], uuid: SecureRandom.hex(n=8))
      @survey.save
  
      @response = Response.new(survey_id: @survey.id, loa: '4', adjective_ids: params[:response][:Adjectives], uuid: SecureRandom.hex(n=5))
      @response.save
      
      flash[:notice]="Survey created successfully!"
      redirect_to survey_path(@survey.uuid)
    end
  end
  def index
    @surveys=current_user.surveys
  end
  def show
    words = []
    @survey = Survey.find_by_uuid(params[:id])
    @responses = Response.find(:all, :conditions => ["loa != 4 AND survey_id = ? ",@survey.id])
    @responses.each do |t|
      t.adjectives.each do |k|
        words << k.word
      end
    end
    @words = words.uniq
  end
  
  def destroy
    @survey.destroy
    redirect_to surveys_path
  end
  
  private
  def user_owns_survey?
    @survey = Survey.find_by_uuid(params[:id])
    @survey.user_id == current_user.id
  end
end
