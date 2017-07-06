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

  def recent_registrations
    date = Date.today - params[:days].to_i
    @registrations = Registration.where("created_at > ?", date)
    @title = "Registered in the last #{params[:days].html_safe} days"
    render action: "list"
  end

  def recent_payments
    date = Date.today - params[:days].to_i
    @payments = Payment.unscoped.where("created_at > ?", date).order(created_at: :desc)
    params[:type] = "in the last #{params[:days]} days"
  end

  def loi
    all = Registration.all.order(:lname, :fname)
    if params[:outstanding] == 'true'
      registrations = Registration.outstanding_loi all
      @registrations = params[:grade] == "5th" ? registrations[:s_fifth] : registrations[:s_eighth]
      @title = "Unsigned LOI's"
    else
      registrations = Registration.uploaded_loi all
      @registrations = params[:grade] == "5th" ? registrations[:s_fifth] : registrations[:s_eighth]
      @title = "Signed LOI's"
    end
    render action: "list"
  end

  def onk_member
    all = Registration.all.order(:lname, :fname)
    if params[:member] == 'true'
      registrations = Registration.onk_members all
      @registrations = params[:grade] == "5th" ? registrations[:s_fifth] : registrations[:s_eighth]
      @title = "ONK Members #{params[:grade].html_safe}"
    else
      registrations = Registration.not_onk_members all
      @registrations = params[:grade] == "5th" ? registrations[:s_fifth] : registrations[:s_eighth]
      @title = "Not ONK Members #{params[:grade].html_safe}"
    end
    render action: "list"
  end

  def registered
    all = Registration.all.order(:lname, :fname)
    registrations = Registration.registered all
    if params[:type] == "Students"
      @registrations = params[:grade] == "5th" ? registrations[:s_fifth] : registrations[:s_eighth]
    else
      @registrations = params[:grade] == "5th" ? registrations[:c_fifth] : registrations[:c_eighth]
    end
    @title = "Registered #{params[:grade].html_safe} #{params[:type].html_safe}"
    render action: "list"
  end

  def withdrawn
    all = Registration.all.order(:lname, :fname)
    registrations = Registration.withdrawn all
    if params[:type] == "Students"
      @registrations = params[:grade] == "5th" ? registrations[:s_fifth] : registrations[:s_eighth]
    else
      @registrations = params[:grade] == "5th" ? registrations[:c_fifth] : registrations[:c_eighth]
    end
    @title = "Withdrawn #{params[:grade].html_safe} #{params[:type].html_safe}"
    render action: "list"
  end

  def scholarships
    all = Registration.all.order(:lname, :fname)
    registrations = Registration.scholarships all
    @registrations = params[:grade] == "5th" ? registrations[:s_fifth] : registrations[:s_eighth]
    @title = "Scholarships #{params[:grade].html_safe}"
    render action: "list"
  end

  def collected
    all = Registration.all.order(:lname, :fname)
    registrations = Registration.collected all
    if params[:type] == "Students"
      @registrations = params[:grade] == "5th" ? registrations[:s_fifth] : registrations[:s_eighth]
    else
      @registrations = params[:grade] == "5th" ? registrations[:c_fifth] : registrations[:c_eighth]
    end
    @title = "Collected #{params[:grade].html_safe} #{params[:type].html_safe}"
    render action: "list"
  end

  def past_due
    all = Registration.all.order(:lname, :fname)
    registrations = Registration.past_due all
    if params[:type] == "Students"
      @registrations = params[:grade] == "5th" ? registrations[:s_fifth] : registrations[:s_eighth]
    else
      @registrations = params[:grade] == "5th" ? registrations[:c_fifth] : registrations[:c_eighth]
    end
    @title = "Past Due #{params[:grade].html_safe} #{params[:type].html_safe}"
    render action: "list"
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
    @payment.pmtdate = Date.strptime(params[:payment]["pmtdate"], "%m/%d/%Y")
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

  def update_onk
    registration = Registration.find(params[:id])
    registration.parent.update_attribute(:onk, params[:onk_member])
    redirect_to tmgr_form_view_path, notice: 'ONK status has bee updated.'
  end

  def update_chap
    registration = Registration.find(params[:id])
    registration.user.update_attribute(:chaperone, params[:chaperone])
    redirect_to tmgr_form_view_path, notice: 'Chaperone status has bee updated.'
  end

  def update_with
    registration = Registration.find(params[:id])
    registration.update_attribute(:withdrawn, params[:withdrawn])
    redirect_to tmgr_form_view_path, notice: 'Withdrawn status has bee updated.'
  end

  def scholarship
    registration = Registration.find(params[:id])
    registration.update_attribute(:scholarship, params[:registration]['scholarship'])
    redirect_to tmgr_form_view_path(params[:id]), notice: 'Scholarship has been updated.'
  end

end