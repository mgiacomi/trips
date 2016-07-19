class PaymentsController < ApplicationController
  before_filter :authenticate_user!

  def overview
    @schedule = Payment.get_student_pay_schedule
  end

end
