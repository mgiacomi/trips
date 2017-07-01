module RegisterHelper

  def textByGrade(grade)
    case grade
      when 5
        "5th Grade"
      when 8
        "8th Grade"
      when 11
        "High School"
      else
        "Unknown grade #{grade}"
    end
  end

end
