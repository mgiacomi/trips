class RegistrationsController < ApplicationController
  before_filter :authenticate_user!

  def edit
    @registration = Registration.find_or_initialize_by(user_id: current_user.id)
  end

  def update
    @registration = Registration.find_or_create_by(user_id: current_user.id)

    if @registration.update_attributes(params[:registration])
      redirect_to todos_home_path, notice: 'Registration was successfully updated.'
    else
      render :action => "edit"
    end
  end

  def denied
  end

end
