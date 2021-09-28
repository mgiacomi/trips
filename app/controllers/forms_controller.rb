class FormsController < ApplicationController
  before_action :authenticate_user!

  def loi_new
    @registration = Registration.where("user_id=? and id=?", current_user.id, params[:id]).first
    @loi = Loi.find_or_initialize_by(registration_id: @registration.id)
  end

  def loi_create
    @registration = Registration.where("user_id=? and id=?", current_user.id, params[:id]).first
    @loi = Loi.find_or_initialize_by(registration_id: @registration.id)
    @loi.user = @registration.user

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

    if @loi.update(sign_params)
      redirect_to todos_home_path, notice: 'LOI Signed successfully.'
    else
      render 'loi_new'
    end
  end

  def sign_params
    params.require(:loi).permit(:p1name, :p1phone, :p1email, :p1address, :p1signature, :p1sigdate, :p1understand, :p1relationship, :p2name, :p2phone, :p2email, :p2address, :p2signature, :p2sigdate, :p2understand, :p2relationship)
  end
end
