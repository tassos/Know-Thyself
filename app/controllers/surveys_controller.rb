class SurveysController < ApplicationController
  before_filter :authenticate_user!
  def new
    @survey = Survey.new
    @self_response = SelfResponse.new
    @adjectives = Adjective.all.order(:word)
  end
  def create
    
    @survey.user_id = current_user.id
    @survey.save


    @selfResponse.surve_id = @survey.id
    @selfResponse.save
    
    redirect_to survey_index_path
    
  end
  def index
    @surveys=current_user.surveys
  end
end
