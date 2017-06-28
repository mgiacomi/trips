module PaymentSummary
  extend ActiveSupport::Concern

  module ClassMethods
  end

  def total_amount
    500
  end

  def total_due
    100
  end

  def total_paid
    400
  end

  def payoff_amount
    total_amount - total_paid
  end

  def next_pmt_date
    Date.strptime("5/26/2017", '%m/%d/%Y')
  end

end