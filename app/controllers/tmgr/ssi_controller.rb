class Tmgr::SsiController < Tmgr::CommonController
  before_filter :authenticate_user!
  before_filter do
    redirect_to :denied unless current_user.ssi_admin?
  end

  def index
    @summary = Registration.get_summary
  end

  def report
    all = Registration.all.order(:lname, :fname)
    registrations = Registration.registered all
    @registrations = registrations[:s_ssi]
    render action: "registrations"
  end

end