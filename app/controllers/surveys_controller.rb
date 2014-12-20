class SurveysController < ApplicationController
  before_filter :authenticate_user_or_admin!, :only => [:index, :send_survey_invitations]
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
        @survey = Survey.new(user_id: find_user(params[:survey][:non_user]).id, name: params[:survey][:name], uuid: SecureRandom.hex(n=8), adminid: SecureRandom.hex(n=8))
        @survey.save
    
        @response = Response.new(survey_id: @survey.id, loa: 4, adjective_ids: ids.uniq, uuid: SecureRandom.hex(n=5))
        @response.save
        
        flash[:notice]="Survey created successfully!"
        redirect_to survey_path(@survey.adminid)
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
      self_words = []
      @survey = Survey.find_by_adminid(params[:id])
      @responses = @survey.responses.find(:all, :conditions => "loa != 4")
      @self_response = @survey.responses.find(:first, :conditions => "loa = 4")
      @self_response.adjectives.each do |p|
        self_words << p.word
      end
      @responses.each do |t|
        t.adjectives.each do |k|
          words << k.word
        end
      end
      @words = Hash[words.group_by {|x| x}.map {|k,v| [k,v.count]}]

      # Finding the words to build the window (words that belong to
      # both groups and words that belong to one of the two groups)
      just_words = words.uniq
      @to_both = just_words & self_words
      @to_them = self_words - just_words
      @to_you = just_words - self_words

      respond_to do |format|
        format.html
        format.csv
    end
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
    flash[:notice]="Survey was deleted successfully"
    redirect_to root_path
  end
  
  private
  def find_user(params)
    if user_signed_in?
      current_user
    elsif admin_signed_in?
      current_admin
    else
      @user = User.find_by_email(params[:email])
      if @user.nil? || @user.registered
        @user = User.new(name: params[:username], email: params[:email], password: 'unregistered', registered: false, uuid: SecureRandom.hex(n=4))
        @user.save!
      end
      return @user
    end
  end

  def user_owns_survey?
    if admin_signed_in?
      return true
    else
      @survey = Survey.find_by_adminid(params[:id])
      if !@survey.user.registered
        return true
      elsif user_signed_in?
        @survey.user_id == current_user.id
      end
    end
  end

  def authenticate_user_or_admin!
    unless user_signed_in? or admin_signed_in?
      redirect_to root_url , :flash => {:alert => "You need to sign in as admin/user before continuing.".html_safe }
    end
  end
end
