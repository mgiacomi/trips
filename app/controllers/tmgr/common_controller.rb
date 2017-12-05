class Tmgr::CommonController < ApplicationController

  def onk_member
    all = Registration.all.order(:lname, :fname)
    if params[:member] == 'true'
      registrations = Registration.onk_members all
      @registrations = params[:grade] == "5th" ? registrations[:s_fifth] : params[:grade] == "8th" ? registrations[:s_eighth] : registrations[:s_ssi]
      @stitle = "ONK Members #{params[:grade].html_safe}"
    else
      registrations = Registration.not_onk_members all
      @registrations = params[:grade] == "5th" ? registrations[:s_fifth] : params[:grade] == "8th" ? registrations[:s_eighth] : registrations[:s_ssi]
      @title = "Not ONK Members #{params[:grade].html_safe}"
    end
    render action: "list"
  end

  def registered
    all = Registration.all.order(:lname, :fname)
    registrations = Registration.registered all
    if params[:type] == "Students"
      @registrations = params[:grade] == "5th" ? registrations[:s_fifth] : params[:grade] == "8th" ? registrations[:s_eighth] : registrations[:s_ssi]
    else
      @registrations = params[:grade] == "5th" ? registrations[:c_fifth] : registrations[:c_eighth]
    end
    @title = "Registered #{params[:grade].html_safe} #{params[:type].html_safe}"
    render action: "list"
  end

  def withdrawn
    all = Registration.all.order(:lname, :fname)
    registrations = Registration.withdrawn all
    if params[:type] == "Students"
      @registrations = params[:grade] == "5th" ? registrations[:s_fifth] : params[:grade] == "8th" ? registrations[:s_eighth] : registrations[:s_ssi]
    else
      @registrations = params[:grade] == "5th" ? registrations[:c_fifth] : registrations[:c_eighth]
    end
    @title = "Withdrawn #{params[:grade].html_safe} #{params[:type].html_safe}"
    render action: "list"
  end

  def scholarships
    all = Registration.all.order(:lname, :fname)
    registrations = Registration.scholarships all
    @registrations = params[:grade] == "5th" ? registrations[:s_fifth] : params[:grade] == "8th" ? registrations[:s_eighth] : registrations[:s_ssi]
    @title = "Scholarships #{params[:grade].html_safe}"
    render action: "list"
  end

  def collected
    all = Registration.all.order(:lname, :fname)
    registrations = Registration.collected all
    if params[:type] == "Students"
      @registrations = params[:grade] == "5th" ? registrations[:s_fifth] : params[:grade] == "8th" ? registrations[:s_eighth] : registrations[:s_ssi]
    else
      @registrations = params[:grade] == "5th" ? registrations[:c_fifth] : registrations[:c_eighth]
    end
    @title = "Collected #{params[:grade].html_safe} #{params[:type].html_safe}"
    render action: "list"
  end

  def past_due
    all = Registration.all.order(:lname, :fname)
    registrations = Registration.past_due all
    if params[:type] == "Students"
      @registrations = params[:grade] == "5th" ? registrations[:s_fifth] : params[:grade] == "8th" ? registrations[:s_eighth] : registrations[:s_ssi]
    else
      @registrations = params[:grade] == "5th" ? registrations[:c_fifth] : registrations[:c_eighth]
    end
    @title = "Past Due #{params[:grade].html_safe} #{params[:type].html_safe}"
    render action: "list"
  end


end