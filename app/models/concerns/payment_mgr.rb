module PaymentMgr
  extend ActiveSupport::Concern

  module ClassMethods
    def get_5th_pay_schedule
      records = Array.new
      records << {date: Date.strptime("7/1/2019", '%m/%d/%Y'), student: 200, chaperone: 0}
      records << {date: Date.strptime("8/15/2019", '%m/%d/%Y'), student: 500, chaperone: 0}
      records << {date: Date.strptime("10/15/2019", '%m/%d/%Y'), student: 500, chaperone: 0}
      records << {date: Date.strptime("11/1/2019", '%m/%d/%Y'), student: 0, chaperone: 0}
      records << {date: Date.strptime("11/15/2019", '%m/%d/%Y'), student: 500, chaperone: 700}
      records << {date: Date.strptime("1/15/2020", '%m/%d/%Y'), student: 500, chaperone: 675}
      records << {date: Date.strptime("3/15/2020", '%m/%d/%Y'), student: 500, chaperone: 675}
      records << {date: Date.strptime("4/15/2020", '%m/%d/%Y'), student: 500, chaperone: 650}
      records << {date: Date.strptime("5/15/2020", '%m/%d/%Y'), student: 150, chaperone: 0}
    end

    def get_8th_pay_schedule
      records = Array.new
      records << {date: Date.strptime("7/1/2019", '%m/%d/%Y'), student: 100, chaperone: 0}
      records << {date: Date.strptime("10/17/2019", '%m/%d/%Y'), student: 600, chaperone: 0}
      records << {date: Date.strptime("11/14/2019", '%m/%d/%Y'), student: 600, chaperone: 0}
      records << {date: Date.strptime("1/9/2020", '%m/%d/%Y'), student: 600, chaperone: 500}
      records << {date: Date.strptime("2/6/2020", '%m/%d/%Y'), student: 600, chaperone: 500}
      records << {date: Date.strptime("3/5/2020", '%m/%d/%Y'), student: 600, chaperone: 500}
      records << {date: Date.strptime("4/2/2020", '%m/%d/%Y'), student: 0, chaperone: 200}
    end

    def get_ssi_pay_schedule
      records = Array.new
      records << {date: Date.strptime("11/15/2019", '%m/%d/%Y'), student: 250, chaperone: 0}
      records << {date: Date.strptime("1/15/2020", '%m/%d/%Y'), student: 2500, chaperone: 0}
      records << {date: Date.strptime("3/15/2020", '%m/%d/%Y'), student: 250, chaperone: 0}
    end
  end

  def get_schedule
    if self.grade == 5
      Registration.get_5th_pay_schedule
    elsif self.grade == 8
      Registration.get_8th_pay_schedule
    elsif self.grade == 11
      Registration.get_ssi_pay_schedule
    else
      Array.new
    end
  end

  def total_amount
    schedule = get_schedule
    due = schedule.map { |r| r[:student] }.reduce { |map, n| map + n }

    if self.chaperone
      due += schedule.map { |r| r[:chaperone] }.reduce { |map, n| map + n }
    end

    due
  end

  def total_paid
    total = 0
    self.payments.each do |pmt|
      total += pmt.amount.to_f
    end
    total
  end

  def total_due
    schedule = get_schedule

    due = schedule.map { |r|
      r[:date] < Date.today ? r[:student] : 0
    }.reduce { |map, n| map + n }

    if self.chaperone
      due += schedule.map { |r|
        r[:date] < Date.today ? r[:chaperone] : 0
      }.reduce { |map, n| map + n }
    end

    due = due - total_paid - self.scholarship
    due > 0 ? due : 0
  end

  def payoff_amount
    total_amount - total_paid
  end

  def next_pmt_date
    schedule = get_schedule
    sofar = 0

    schedule.each do |r|
      sofar += r[:student]

      if self.chaperone
        sofar += r[:chaperone]
      end

      if sofar > total_paid
        return r[:date]
      end
    end

    Date.strptime("5/26/2020", '%m/%d/%Y')
  end

end