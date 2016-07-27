module SummaryMgr
  extend ActiveSupport::Concern

  module ClassMethods
    def get_summary
      all = Registration.order(:slname).all
      {
          registered: registered(all),
          outstanding_loi: outstanding_loi(all),
          uploaded_loi: uploaded_loi(all),
          collected: collected(all),
          past_due: past_due(all)
      }
    end

    def registered all
      s_fifth = all.select do |reg|
        reg.grade == 5 && !reg.user.chaperone
      end
      s_eighth = all.select do |reg|
        reg.grade == 8 && !reg.user.chaperone
      end
      c_fifth = all.select do |reg|
        reg.grade == 5 && reg.user.chaperone
      end
      c_eighth = all.select do |reg|
        reg.grade == 8 && reg.user.chaperone
      end
      total = s_fifth.length + s_eighth.length + c_fifth.length + c_eighth.length
      {s_fifth: s_fifth, s_eighth: s_eighth, c_fifth: c_fifth, c_eighth: c_eighth, total: total}
    end

    def outstanding_loi all
      s_fifth = all.select do |reg|
        reg.grade == 5 && !reg.user.chaperone && reg.file_name.nil?
      end
      s_eighth = all.select do |reg|
        reg.grade == 8 && !reg.user.chaperone && reg.file_name.nil?
      end
      total = s_fifth.length + s_eighth.length
      {s_fifth: s_fifth, s_eighth: s_eighth, total: total}
    end

    def uploaded_loi all
      s_fifth = all.select do |reg|
        reg.grade == 5 && !reg.user.chaperone && !reg.file_name.nil?
      end
      s_eighth = all.select do |reg|
        reg.grade == 8 && !reg.user.chaperone && !reg.file_name.nil?
      end
      total = s_fifth.length + s_eighth.length
      {s_fifth: s_fifth, s_eighth: s_eighth, total: total}
    end

    def collected all
      s_fifth = all.select { |reg| reg.grade == 5 && !reg.user.chaperone }
      s_eighth = all.select { |reg| reg.grade == 8 && !reg.user.chaperone }
      c_fifth = all.select { |reg| reg.grade == 5 && reg.user.chaperone }
      c_eighth = all.select { |reg| reg.grade == 8 && reg.user.chaperone }

      s_fifth_r = s_fifth.map{|r| r.total_paid}.reduce {|sum, n| sum + n}
      s_eighth_r = s_eighth.map{|r| r.total_paid}.reduce {|sum, n| sum + n}
      c_fifth_r = c_fifth.map{|r| r.total_paid}.reduce {|sum, n| sum + n}
      c_eighth_r = c_eighth.map{|r| r.total_paid}.reduce {|sum, n| sum + n}

      s_fifth_r = s_fifth_r.nil? ? 0 : s_fifth_r
      s_eighth_r = s_eighth_r.nil? ? 0 : s_eighth_r
      c_fifth_r = c_fifth_r.nil? ? 0 : c_fifth_r
      c_eighth_r = c_eighth_r.nil? ? 0 : c_eighth_r

      total = s_fifth_r + s_eighth_r + c_fifth_r + c_eighth_r

      {s_fifth: s_fifth, s_eighth: s_eighth, c_fifth: c_fifth, c_eighth: c_eighth, total: total,
       s_fifth_r: s_fifth_r, s_eighth_r: s_eighth_r, c_fifth_r: c_fifth_r, c_eighth_r: c_eighth_r}
    end

    def past_due all
      s_fifth = all.select { |reg| reg.grade == 5 && !reg.user.chaperone }
      s_eighth = all.select { |reg| reg.grade == 8 && !reg.user.chaperone }
      c_fifth = all.select { |reg| reg.grade == 5 && reg.user.chaperone }
      c_eighth = all.select { |reg| reg.grade == 8 && reg.user.chaperone }

      s_fifth_r = s_fifth.map{|r| r.total_due}.reduce {|sum, n| sum + n}
      s_eighth_r = s_eighth.map{|r| r.total_due}.reduce {|sum, n| sum + n}
      c_fifth_r = c_fifth.map{|r| r.total_due}.reduce {|sum, n| sum + n}
      c_eighth_r = c_eighth.map{|r| r.total_due}.reduce {|sum, n| sum + n}

      s_fifth_r = s_fifth_r.nil? ? 0 : s_fifth_r
      s_eighth_r = s_eighth_r.nil? ? 0 : s_eighth_r
      c_fifth_r = c_fifth_r.nil? ? 0 : c_fifth_r
      c_eighth_r = c_eighth_r.nil? ? 0 : c_eighth_r

      total = s_fifth_r + s_eighth_r + c_fifth_r + c_eighth_r

      {s_fifth: s_fifth, s_eighth: s_eighth, c_fifth: c_fifth, c_eighth: c_eighth, total: total,
       s_fifth_r: s_fifth_r, s_eighth_r: s_eighth_r, c_fifth_r: c_fifth_r, c_eighth_r: c_eighth_r}
    end
  end

end