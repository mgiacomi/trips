class Tmgr::OverviewsController < Tmgr::CommonController
  before_action :authenticate_user!
  before_action :check_privileges!, only: [:payment, :payment_delete, :toggle_with, :toggle_chap, :toggle_onk,  :scholarship, :delete]
  before_action do
    redirect_to :denied unless current_user.admin?
  end

  def check_privileges!
    redirect_to :denied unless current_user.super_admin?
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

  def view
    @registration = Registration.find(params[:id])
    @payment = Payment.new
    @payment.registration = @registration
  end

  def payment
    @registration = Registration.find(params[:id])
    @payment = Payment.new(payment_params)
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

  def toggle_onk
    registration = Registration.find(params[:id])
    unless registration.parent.nil?
    registration.parent.toggle :onk
    registration.parent.save
    end
    redirect_to tmgr_form_view_path, notice: 'ONK status has been updated.'
  end

  def toggle_chap
    registration = Registration.find(params[:id])
    registration.toggle :chaperone
    registration.save
    redirect_to tmgr_form_view_path, notice: 'Chaperone has been updated.'
  end

  def toggle_with
    registration = Registration.find(params[:id])
    registration.toggle :withdrawn
    registration.save
    redirect_to tmgr_form_view_path, notice: 'Withdrawn status has bee updated.'
  end

  def scholarship
    registration = Registration.find(params[:id])
    registration.update_attribute(:scholarship, params[:registration]['scholarship'])
    redirect_to tmgr_form_view_path(params[:id]), notice: 'Scholarship has been updated.'
  end

  def delete
    registration = Registration.find(params[:id])
    registration.destroy
    redirect_to tmgr_overview_path, notice: 'Registration has been removed.'
  end

  def fifthgrade
    all = Registration.all.order(:lname, :fname)
    registrations = Registration.registered all
    @registrations = []
    @registrations << registrations[:s_fifth]
    @registrations << registrations[:c_fifth]
    @registrations.flatten!
    render action: "registrations"
  end

  def eighthgrade
    all = Registration.all.order(:lname, :fname)
    registrations = Registration.registered all
    @registrations = []
    @registrations << registrations[:s_eighth]
    @registrations << registrations[:c_eighth]
    @registrations.flatten!
    render action: "registrations"
  end

  def latepayments
    all = Registration.all.order(:lname, :fname)
    registrations = Registration.past_due all

    @registrations = []
    @registrations << registrations[:s_fifth]
    @registrations << registrations[:c_fifth]
    @registrations << registrations[:s_eighth]
    @registrations << registrations[:c_eighth]
    @registrations << registrations[:s_ssi]
    @registrations.flatten!
  end

  def payment_params
    params.require(:payment).permit(:registration_id, :pmtnum, :pmtdate, :amount, :fee)
  end

end