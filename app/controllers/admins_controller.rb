class AdminsController < ApplicationController
  before_filter :authenticate_admin!
end
