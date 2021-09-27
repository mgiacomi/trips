class FormsController < ApplicationController
  before_action :authenticate_user!

  def loi_new
    @registration = Registration.where("user_id=? and id=?", current_user.id, params[:id]).first
    @loi = Loi.find_or_initialize_by(registration_id: @registration.id)
  end

  def loi_create
    @registration = Registration.where("user_id=? and id=?", current_user.id, params[:id]).first
    @loi = Loi.find_or_initialize_by(registration_id: @registration.id)

    # Needs to move to a concern?
    unless params[:loi]['p1sigdate'].blank?
      begin
        params[:loi]['p1sigdate'] = Date.strptime(params[:loi]['p1sigdate'], "%m/%d/%Y")
      rescue
        params[:loi]['p1sigdate'] = ''
      end
    end

    # Needs to move to a concern?
    unless params[:loi]['p2sigdate'].blank?
      begin
        params[:loi]['p2sigdate'] = Date.strptime(params[:loi]['p2sigdate'], "%m/%d/%Y")
      rescue
        params[:loi]['p2sigdate'] = ''
      end
    end

    if @loi.update_attributes(params[:loi])
      redirect_to todos_home_path, notice: 'LOI Signed successfully.'
    else
      render 'loi_new'
    end
  end
end
