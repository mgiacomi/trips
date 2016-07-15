module SummaryMgr
  extend ActiveSupport::Concern

  module ClassMethods
    def get_summary
      all = Registrations.all
      {
          outstanding_loi: outstanding_loi(all),
          uploaded_loi: uploaded_loi(all),
          registered: registered(all),
          collected: collected(all),
          past_due: past_due(all)
      }
    end

    def outstanding_loi all
      s_fifth = all.select do |reg|
        reg.grade == "5" && !reg.user.chaperone && registration.file_name.nil?
      end
      s_eighth = all.select do |reg|
        reg.grade == "8" && !reg.user.chaperone && registration.file_name.nil?
      end
    end

    def uploaded_loi all
      s_fifth = all.select do |reg|
        reg.grade == "5" && !reg.user.chaperone && !registration.file_name.nil?
      end
      s_eighth = all.select do |reg|
        reg.grade == "8" && !reg.user.chaperone && !registration.file_name.nil?
      end
    end

    def registered all
      s_fifth = all.select do |reg|
        reg.grade == "5" && !reg.user.chaperone
      end
      s_eighth = all.select do |reg|
        reg.grade == "8" && !reg.user.chaperone
      end
      c_fifth = all.select do |reg|
        reg.grade == "5" && reg.user.chaperone
      end
      c_eighth = all.select do |reg|
        reg.grade == "8" && reg.user.chaperone
      end

      {s_fifth: s_fifth, s_eighth: s_eighth, c_fifth: c_fifth, c_eighth: c_eighth}
    end

    def collected all

    end

    def past_due all

    end
  end

end