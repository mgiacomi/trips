class RegistrationsController < ApplicationController
  before_action :authenticate_user!

  def new
    @registration = Registration.new
  end

  def edit
    @registration = Registration.where("user_id=? and id=?", current_user.id, params[:id]).first
  end

  def create
    @registration = Registration.create(user_id: current_user.id)
    @registration.parent = Parent.find_by_user_id(current_user.id)

    # Needs to move to a concern?
    unless params[:registration]['date_of_birth'].blank?
      begin
        params[:registration]['date_of_birth'] = Date.strptime(params[:registration]['date_of_birth'], "%m/%d/%Y")
      rescue
        params[:registration]['date_of_birth'] = ''
      end
    end

    begin
      if @registration.update(registration_params)
        redirect_to loi_new_path(@registration.id), notice: 'Registration was successfully updated.'
      else
        render :action => "new"
      end
    rescue ActiveRecord::RecordNotUnique => e
      redirect_to todos_home_path, alert: 'Error Adding Registration: Likely duplicate First/Last name.'
    end
  end

  def update
    @registration = Registration.where('user_id=? and id=?', current_user.id, params[:id]).first

    # Needs to move to a concern?
    unless params[:registration]['date_of_birth'].blank?
      begin
        params[:registration]['date_of_birth'] = Date.strptime(params[:registration]['date_of_birth'], "%m/%d/%Y")
      rescue
        params[:registration]['date_of_birth'] = ''
      end
    end

    if @registration.update(registration_params)
      redirect_to todos_home_path, notice: 'Registration was successfully updated.'
    else
      render :action => "edit"
    end
  end

  def denied
  end

  def registration_params
    params.require(:registration).permit(:fname, :mname, :lname, :gender, :gender_pronoun, :grade, :date_of_birth, :ec_name, :ec_relationship, :ec_phone, :ec_address)
  end

end
