class AdminsController < ApplicationController
  before_filter :authenticate_admin!
  def index
    @adjectives = Adjective.where(visibility:1).pluck(:word).sort
  end
end
