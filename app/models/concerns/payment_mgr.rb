module PaymentMgr
  extend ActiveSupport::Concern

  module ClassMethods
    def get_student_pay_schedule
      records = Array.new
      records << {date: Date.strptime("6/30/2016", '%m/%d/%Y'), amount: 400}
      records << {date: Date.strptime("8/15/2016", '%m/%d/%Y'), amount: 500}
      records << {date: Date.strptime("10/15/2016", '%m/%d/%Y'), amount: 600}
      records << {date: Date.strptime("11/15/2016", '%m/%d/%Y'), amount: 700}
      records << {date: Date.strptime("12/15/2016", '%m/%d/%Y'), amount: 900}
      records << {date: Date.strptime("1/15/2016", '%m/%d/%Y'), amount: 800}
      records << {date: Date.strptime("2/15/2016", '%m/%d/%Y'), amount: 700}
      records << {date: Date.strptime("3/15/2016", '%m/%d/%Y'), amount: 600}
    end

    def get_chaperone_pay_schedule
      records = Array.new
      records << {date: Date.strptime("6/30/2016", '%m/%d/%Y'), amount: 400}
      records << {date: Date.strptime("12/15/2016", '%m/%d/%Y'), amount: 900}
      records << {date: Date.strptime("1/15/2016", '%m/%d/%Y'), amount: 800}
      records << {date: Date.strptime("2/15/2016", '%m/%d/%Y'), amount: 700}
      records << {date: Date.strptime("3/15/2016", '%m/%d/%Y'), amount: 600}
    end
  end

  def total_payments
    total = 0
    self.payments.each do |pmt|
      total += pmt.amount.to_i
    end
    total
  end

end