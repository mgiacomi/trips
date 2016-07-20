class Tmgr::OverviewsController < ApplicationController
  before_filter :authenticate_user!
  before_filter do
    redirect_to :denied unless current_user.admin?
  end

  def index
    @summary = Registration.get_summary
  end

  def search
    @results = Registration.search params[:term]
  end

  def loi
    all = Registration.all
    if params[:outstanding] == 'true'
      registrations = Registration.outstanding_loi all
      @registrations = params[:grade] == "5th" ? registrations[:s_fifth] : registrations[:s_eighth]
      @title = "Oustanding LOI's"
    else
      registrations = Registration.uploaded_loi all
      @registrations = params[:grade] == "5th" ? registrations[:s_fifth] : registrations[:s_eighth]
      @title = "Uploaded LOI's"
    end
  end

  def registered
    all = Registration.all
    registrations = Registration.registered all
    if params[:type] == "Students"
      @registrations = params[:grade] == "5th" ? registrations[:s_fifth] : registrations[:s_eighth]
    else
      @registrations = params[:grade] == "5th" ? registrations[:c_fifth] : registrations[:c_eighth]
    end
  end

  def view
    @registration = Registration.find(params[:id])
    @payment = Payment.new
    @payment.registration = @registration
  end

  def download_loi
    registration = Registration.find(params[:id])
    file_path = "#{Rails.configuration.loi_file_dir}/#{registration.id}#{registration.file_ext}"
    send_file file_path, disposition: 'attachment', filename: registration.file_url
  end

  def payment
    @registration = Registration.find(params[:id])
    @payment = Payment.new(params[:payment])
    @payment.registration = @registration
    @payment.user = current_user

    if @payment.save
      redirect_to tmgr_form_view_path, notice: 'Payment has been added.'
    else
      render action: "view", alert: "Failed to add Payment."
    end
  end

  def payment_delete
    payment = Payment.find params[:id]

    if payment.delete
      redirect_to tmgr_form_view_path(params[:reg_id]), notice: 'Payment has been delete.'
    else
      redirect_to tmgr_form_view_path(params[:reg_id]), alert: 'Failed to delete payment.'
    end
  end
end