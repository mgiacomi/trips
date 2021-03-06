module SummaryMgr
  extend ActiveSupport::Concern

  module ClassMethods
    def get_summary
      all = Registration.all
      {
          registered: registered(all),
          withdrawn: withdrawn(all),
          onk_members: onk_members(all),
          not_onk_members: not_onk_members(all),
          outstanding_loi: outstanding_loi(all),
          uploaded_loi: uploaded_loi(all),
          scholarships: scholarships(all),
          collected: collected(all),
          past_due: past_due(all)
      }
    end

    def registered all
      s_ssi = all.select do |reg|
        reg.grade == 11 && !reg.withdrawn
      end
      s_fifth = all.select do |reg|
        reg.grade == 5 && !reg.withdrawn
      end
      s_eighth = all.select do |reg|
        reg.grade == 8 && !reg.withdrawn
      end
      c_fifth = all.select do |reg|
        reg.grade == 5 && !reg.withdrawn && reg.chaperone
      end
      c_eighth = all.select do |reg|
        reg.grade == 8 && !reg.withdrawn && reg.chaperone
      end
      total = s_fifth.length + s_eighth.length + c_fifth.length + c_eighth.length + s_ssi.length
      {s_ssi: s_ssi, s_fifth: s_fifth, s_eighth: s_eighth, c_fifth: c_fifth, c_eighth: c_eighth, total: total}
    end

    def withdrawn all
      s_ssi = all.select do |reg|
        reg.grade == 11 && reg.withdrawn
      end
      s_fifth = all.select do |reg|
        reg.grade == 5 && reg.withdrawn
      end
      s_eighth = all.select do |reg|
        reg.grade == 8 && reg.withdrawn
      end
      c_fifth = all.select do |reg|
        reg.grade == 5 && reg.withdrawn && reg.chaperone
      end
      c_eighth = all.select do |reg|
        reg.grade == 8 && reg.withdrawn && reg.chaperone
      end
      total = s_fifth.length + s_eighth.length + c_fifth.length + c_eighth.length + s_ssi.length
      {s_ssi: s_ssi, s_fifth: s_fifth, s_eighth: s_eighth, c_fifth: c_fifth, c_eighth: c_eighth, total: total}
    end

    def not_onk_members all
      s_ssi = all.select do |reg|
        reg.grade == 11 && !reg.withdrawn && !reg.parent.onk
      end
      s_fifth = all.select do |reg|
        reg.grade == 5 && !reg.withdrawn && !reg.parent.onk
      end
      s_eighth = all.select do |reg|
        reg.grade == 8 && !reg.withdrawn && !reg.parent.onk
      end
      total = s_fifth.length + s_eighth.length + s_ssi.length
      {s_ssi: s_ssi, s_fifth: s_fifth, s_eighth: s_eighth, total: total}
    end

    def onk_members all
      s_ssi = all.select do |reg|
        reg.grade == 11 && !reg.withdrawn && reg.parent.onk
      end
      s_fifth = all.select do |reg|
        reg.grade == 5 && !reg.withdrawn && reg.parent.onk
      end
      s_eighth = all.select do |reg|
        reg.grade == 8 && !reg.withdrawn && reg.parent.onk
      end
      total = s_fifth.length + s_eighth.length
      {s_ssi: s_ssi, s_fifth: s_fifth, s_eighth: s_eighth, total: total}
    end

    def outstanding_loi all
      s_fifth = all.select do |reg|
        reg.grade == 5 && !reg.withdrawn && (reg.loi.nil? || reg.loi.p1signature.blank?)
      end
      s_eighth = all.select do |reg|
        reg.grade == 8 && !reg.withdrawn && (reg.loi.nil? || reg.loi.p1signature.blank?)
      end
      total = s_fifth.length + s_eighth.length
      {s_fifth: s_fifth, s_eighth: s_eighth, total: total}
    end

    def uploaded_loi all
      s_fifth = all.select do |reg|
        reg.grade == 5 && !reg.withdrawn && !reg.loi.nil? && !reg.loi.p1signature.blank?
      end
      s_eighth = all.select do |reg|
        reg.grade == 8 && !reg.withdrawn && !reg.loi.nil? && !reg.loi.p1signature.blank?
      end
      total = s_fifth.length + s_eighth.length
      {s_fifth: s_fifth, s_eighth: s_eighth, total: total}
    end

    def scholarships all
      s_ssi = all.select do |reg|
        reg.grade == 11 && !reg.withdrawn && !reg.scholarship.nil? && reg.scholarship > 0
      end
      s_fifth = all.select do |reg|
        reg.grade == 5 && !reg.withdrawn && !reg.scholarship.nil? && reg.scholarship > 0
      end
      s_eighth = all.select do |reg|
        reg.grade == 8 && !reg.withdrawn && !reg.scholarship.nil? && reg.scholarship > 0
      end

      s_ssi_r = s_ssi.map{|r| r.scholarship}.reduce {|sum, n| sum + n}
      s_fifth_r = s_fifth.map{|r| r.scholarship}.reduce {|sum, n| sum + n}
      s_eighth_r = s_eighth.map{|r| r.scholarship}.reduce {|sum, n| sum + n}

      s_ssi_r = s_ssi_r.nil? ? 0 : s_ssi_r
      s_fifth_r = s_fifth_r.nil? ? 0 : s_fifth_r
      s_eighth_r = s_eighth_r.nil? ? 0 : s_eighth_r

      total = s_fifth_r + s_eighth_r + s_ssi_r
      {s_ssi: s_ssi, s_fifth: s_fifth, s_eighth: s_eighth, total: total}
    end

    def collected all
      s_ssi = all.select { |reg| reg.grade == 11 && !reg.withdrawn && !reg.chaperone }
      s_fifth = all.select { |reg| reg.grade == 5 && !reg.withdrawn && !reg.chaperone }
      s_eighth = all.select { |reg| reg.grade == 8 && !reg.withdrawn && !reg.chaperone }
      c_fifth = all.select { |reg| reg.grade == 5 && !reg.withdrawn && reg.chaperone }
      c_eighth = all.select { |reg| reg.grade == 8 && !reg.withdrawn && reg.chaperone }

      s_ssi_r = s_ssi.map{|r| r.total_paid}.reduce {|sum, n| sum + n}
      s_fifth_r = s_fifth.map{|r| r.total_paid}.reduce {|sum, n| sum + n}
      s_eighth_r = s_eighth.map{|r| r.total_paid}.reduce {|sum, n| sum + n}
      c_fifth_r = c_fifth.map{|r| r.total_paid}.reduce {|sum, n| sum + n}
      c_eighth_r = c_eighth.map{|r| r.total_paid}.reduce {|sum, n| sum + n}

      s_ssi_r = s_ssi_r.nil? ? 0 : s_ssi_r
      s_fifth_r = s_fifth_r.nil? ? 0 : s_fifth_r
      s_eighth_r = s_eighth_r.nil? ? 0 : s_eighth_r
      c_fifth_r = c_fifth_r.nil? ? 0 : c_fifth_r
      c_eighth_r = c_eighth_r.nil? ? 0 : c_eighth_r

      total = s_ssi_r + s_fifth_r + s_eighth_r + c_fifth_r + c_eighth_r

      {s_ssi: s_ssi, s_fifth: s_fifth, s_eighth: s_eighth, c_fifth: c_fifth, c_eighth: c_eighth, total: total,
       s_ssi_r: s_ssi_r, s_fifth_r: s_fifth_r, s_eighth_r: s_eighth_r, c_fifth_r: c_fifth_r, c_eighth_r: c_eighth_r}
    end

    def past_due all
      s_ssi = all.select { |reg| reg.grade == 11 && !reg.withdrawn && !reg.chaperone && reg.total_due > 0 }
      s_fifth = all.select { |reg| reg.grade == 5 && !reg.withdrawn && !reg.chaperone && reg.total_due > 0 }
      s_eighth = all.select { |reg| reg.grade == 8 && !reg.withdrawn && !reg.chaperone && reg.total_due > 0 }
      c_fifth = all.select { |reg| reg.grade == 5 && !reg.withdrawn && reg.chaperone && reg.total_due > 0 }
      c_eighth = all.select { |reg| reg.grade == 8 && !reg.withdrawn && reg.chaperone && reg.total_due > 0 }

      s_ssi_r = s_ssi.map{|r| r.total_due}.reduce {|sum, n| sum + n}
      s_fifth_r = s_fifth.map{|r| r.total_due}.reduce {|sum, n| sum + n}
      s_eighth_r = s_eighth.map{|r| r.total_due}.reduce {|sum, n| sum + n}
      c_fifth_r = c_fifth.map{|r| r.total_due}.reduce {|sum, n| sum + n}
      c_eighth_r = c_eighth.map{|r| r.total_due}.reduce {|sum, n| sum + n}

      s_ssi_r = s_ssi_r.nil? ? 0 : s_ssi_r
      s_fifth_r = s_fifth_r.nil? ? 0 : s_fifth_r
      s_eighth_r = s_eighth_r.nil? ? 0 : s_eighth_r
      c_fifth_r = c_fifth_r.nil? ? 0 : c_fifth_r
      c_eighth_r = c_eighth_r.nil? ? 0 : c_eighth_r

      total = s_fifth_r + s_eighth_r + c_fifth_r + c_eighth_r

      {s_ssi: s_ssi, s_fifth: s_fifth, s_eighth: s_eighth, c_fifth: c_fifth, c_eighth: c_eighth, total: total,
       s_ssi_r: s_ssi_r, s_fifth_r: s_fifth_r, s_eighth_r: s_eighth_r, c_fifth_r: c_fifth_r, c_eighth_r: c_eighth_r}
    end
  end

end