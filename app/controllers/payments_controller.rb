class PaymentsController < ApplicationController
  before_filter :authenticate_user!, :except => :receipt
  skip_before_action :verify_authenticity_token, :only => :receipt

  def overview
    @registration = Registration.find_or_initialize_by(user_id: current_user.id)

    if current_user.chaperone
      @schedule = Registration.get_chaperone_pay_schedule
    else
      @schedule = Registration.get_student_pay_schedule
    end
  end

  def receipt
    logger.info "Got Payment: #{params[:invoice]} #{params[:payment_gross]} #{params[:payment_status]} #{params[:payment_date]}"

    if params[:payment_status] == "Completed"
      logger.info "got completed payment"
    end
  end
end
