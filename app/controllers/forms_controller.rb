class FormsController < ApplicationController
  before_filter :authenticate_user!

  def loi_new
    @registration = Registration.where("user_id=? and id=?", current_user.id, params[:id]).first
    @loi = Loi.find_or_initialize_by(registration_id: @registration.id)
  end

  def loi_create
    @registration = Registration.where("user_id=? and id=?", current_user.id, params[:id]).first
    @loi = Loi.find_or_initialize_by(registration_id: @registration.id)

    if @loi.update_attributes(params[:loi])
      redirect_to todos_home_path, notice: 'LOI Signed successfully.'
    else
      render 'loi_new'
    end
  end
end
