module RegisterHelper

  def textByGrade(grade)
    case grade
      when 5
        "5th Grade"
      when 8
        "8th Grade"
      when 11
        "SSI"
      else
        "Unknown grade #{grade}"
    end
  end

  def textByGradeShort(grade)
    case grade
      when 5
        "5th"
      when 8
        "8th"
      when 11
        "SSI"
      else
        "Unknown grade #{grade}"
    end
  end

end
