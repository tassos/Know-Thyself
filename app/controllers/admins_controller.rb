class AdminsController < ApplicationController
  before_filter :authenticate_admin!
  def index
    @adjectives = Adjective.pluck(:word).sort
  end
end
