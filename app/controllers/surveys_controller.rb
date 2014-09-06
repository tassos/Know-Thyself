class SurveysController < ApplicationController
  before_filter :authenticate_user!
  before_filter :user_owns_survey?, :only => [:show, :destroy]
  def new
    @survey = Survey.new
    @response = Response.new
    @adjectives = Adjective.where(visibility:1).order(:word).sample(56)
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
      ids = Adjective.update(params[:response][:newAdjectives],0)
      
      if ids == 'error'
        flash[:alert]="The word you entered was too long!"
        redirect_to new_survey_path
      else
        if !params[:response][:Adjectives].nil?
          params[:response][:Adjectives].each {|s| ids << s.to_i}
        end
        @survey = Survey.new(user_id: current_user.id, name: params[:survey][:name], uuid: SecureRandom.hex(n=8))
        @survey.save
    
        @response = Response.new(survey_id: @survey.id, loa: '4', adjective_ids: ids, uuid: SecureRandom.hex(n=5))
        @response.save
        
        flash[:notice]="Survey created successfully!"
        redirect_to survey_path(@survey.uuid)
      end
    end
  end
  def index
    @surveys=current_user.surveys
  end
  def show
    if user_owns_survey?
      words = []
      @survey = Survey.find_by_uuid(params[:id])
      @responses = Response.find(:all, :conditions => ["loa != 4 AND survey_id = ? ",@survey.id])
      @responses.each do |t|
        t.adjectives.each do |k|
          words << k.word
        end
      end
      @words = words.uniq
    else
      flash[:alert]="You are not the owner of this survey"
      redirect_to root_path
    end
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
