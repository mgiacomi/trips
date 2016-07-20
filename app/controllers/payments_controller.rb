class PaymentsController < ApplicationController
  before_filter :authenticate_user!

  def overview
    @registration = Registration.find_or_initialize_by(user_id: current_user.id)

    if current_user.chaperone
      @schedule = Registration.get_chaperone_pay_schedule
    else
      @schedule = Registration.get_student_pay_schedule
    end
  end

end
