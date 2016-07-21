class TodosController < ApplicationController
  before_filter :authenticate_user!, :except => [:denied, :new]

  def status
    redirect_to tmgr_overview_path if current_user.admin
    @registration = Registration.find_by(user_id: current_user.id)
  end

  def denied
  end


end
