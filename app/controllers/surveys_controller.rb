class SurveysController < ApplicationController
  before_filter :authenticate_user_or_admin!
  before_filter :user_owns_survey?, :only => [:show, :destroy]
  def new
    @survey = Survey.new
    @response = Response.new
    @adjectives = Adjective.where(visibility:1).shuffle
  end
  def create
    if (params[:response][:Adjectives].nil? && params[:response][:newAdjectives] == [""])
      flash[:alert]="Please select some adjectives that describe you!"
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
    
        @response = Response.new(survey_id: @survey.id, loa: 4, adjective_ids: ids.uniq, uuid: SecureRandom.hex(n=5))
        @response.save
        
        flash[:notice]="Survey created successfully!"
        redirect_to survey_path(@survey.uuid)
      end
    end
  end
  def index
    if admin_signed_in?
      user_in_question=User.find(params[:id])
    elsif user_signed_in?
      user_in_question=current_user
    end
    @surveys = user_in_question.surveys
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
      @words = Hash[words.group_by {|x| x}.map {|k,v| [k,v.count]}]
    else
      flash[:alert]="You are not the owner of this survey"
      redirect_to root_path
    end
  end

  def send_survey_invitations
    if params[:self]
      cc = current_user.email
    else
      cc = nil
    end
    if params[:invitations].empty?
      flash[:alert]="No e-mails were provided for the invitation"
    else
      params[:invitations].split(',').each do |address|
        InvitationMailer.invitation(address,params[:survey_uuid],cc,current_user).deliver
      end
      flash[:notice]="E-mails were sent!"
    end
    redirect_to survey_path(params[:survey_uuid])
  end
  
  def destroy
    @survey.destroy
    redirect_to surveys_path
  end
  
  private
  def user_owns_survey?
    if admin_signed_in?
      return true
    else
      @survey = Survey.find_by_uuid(params[:id])
      @survey.user_id == current_user.id
    end
  end
  def authenticate_user_or_admin!
    unless user_signed_in? or admin_signed_in?
      redirect_to root_url , :flash => {:alert => "You need to sign in as admin/user before continuing..".html_safe }
    end
  end
end
