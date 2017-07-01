class PaymentsController < ApplicationController
  before_filter :authenticate_user!, :except => [:receipt, :onk_receipt]
  skip_before_action :verify_authenticity_token, :only => [:receipt, :onk_receipt]

  def overview
    @registration = Registration.where('user_id=? and id=?', current_user.id, params[:id]).first

    if @registration.grade == 5
      @schedule = Registration.get_5th_pay_schedule
    elsif @registration.grade == 8
      @schedule = Registration.get_8th_pay_schedule
    elsif @registration.grade == 11
      @schedule = Registration.get_11th_pay_schedule
    end
  end

  def receipt
    if params[:payment_status] == "Completed"
      parent_id = params[:invoice].split('-')[0]
      parent = Parent.find parent_id

      payment = Payment.new
      payment.amount = params[:payment_gross]
      payment.fee = params[:payment_fee]
      payment.pmtdate = params[:payment_date]
      payment.pmtnum = "Paypal"
      payment.parent = parent
      payment.user = parent.user

      if payment.save
        logger.info "Saved Payment: #{params[:invoice]} #{params[:payment_gross]} #{params[:payment_status]} #{params[:payment_date]}"
      else
        logger.info "Failed to save payment: #{params[:invoice]} #{params[:payment_gross]} #{params[:payment_status]} #{params[:payment_date]}"
      end
    end
  end

  def onk_receipt
    if params[:payment_status] == "Completed"
      reg_id = params[:invoice].split('-')[0]
      registration = Registration.find reg_id
      registration.onk = true

      if registration.save
        logger.info "ONK Membership added for registration id: #{registration.id}"
      else
        logger.info "Failed to add ONK Membership for registration id: #{registration.id}"
      end
    end
  end
end
