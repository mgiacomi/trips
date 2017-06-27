class RegistrationsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @registration = Registration.new
  end

  def edit
    @registration = Registration.where("user_id=? and id=?", current_user.id, params[:id]).first
  end

  def create
    @registration = Registration.create(user_id: current_user.id)

    if @registration.update_attributes(params[:registration])
      redirect_to todos_home_path, notice: 'Registration was successfully updated.'
    else
      render :action => "new"
    end
  end

  def update
    @registration = Registration.where('user_id=? and id=?', current_user.id, params[:id]).first

    if @registration.update_attributes(params[:registration])
      redirect_to todos_home_path, notice: 'Registration was successfully updated.'
    else
      render :action => "edit"
    end
  end

  def denied
  end

end
