class TodosController < ApplicationController
  before_filter :authenticate_user!, :except => [:denied, :new]

  def status
    redirect_to tmgr_overview_path if current_user.admin
    @parent = current_user.parent.nil? ? Parent.new(user_id: current_user.id) : Parent.find_by_user_id(current_user.id)
    @registrations = Registration.where(user_id: current_user.id).order(:grade)
  end

  def parents
  end

  def denied
  end



end
