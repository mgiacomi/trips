module PaymentSummary
  extend ActiveSupport::Concern

  module ClassMethods
  end

  def total_amount
    self.user.registrations.map { |r| r.total_amount }.reduce { |map, n| map + n }
  end

  def total_due
    self.user.registrations.map { |r| r.total_due }.reduce { |map, n| map + n }
  end

  def total_paid
    self.user.registrations.map { |r| r.total_paid }.reduce { |map, n| map + n }
  end

  def payoff_amount
    self.user.registrations.map { |r| r.payoff_amount }.reduce { |map, n| map + n }
  end

  def next_pmt_date
    self.user.registrations.map { |r| r.next_pmt_date}.min
  end

end