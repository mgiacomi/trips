class RegistrationsController < ApplicationController
  before_filter :authenticate_user!

  def edit
    @registration = Registration.find_or_initialize_by(user_id: current_user.id)
  end

  def update
    @registration = Registration.find_or_create_by(user_id: current_user.id)

    if @registration.update_attributes(params[:registration])
      redirect_to todos_home_path, notice: 'Registration was successfully updated.'
    else
      render :action => "edit"
    end
  end

  def view_loi

  end

  def download_loi
    registration = Registration.find_by(user_id: current_user.id)
    file_path = "#{Rails.configuration.loi_file_dir}/#{registration.id}#{registration.file_ext}"

    send_file file_path, disposition: 'attachment', filename: "#{registration.file_name}#{registration.file_ext}"

  end

  def upload_loi
    registration = Registration.find_by(user_id: current_user.id)

    if params[:loi_file].instance_of? ActionDispatch::Http::UploadedFile
      registration.file = {filename: params[:loi_file].original_filename, data: params[:loi_file].read}
    else
      registration.file = {filename: params[:loi_file], data: request.raw_post}
    end

    if registration.save
      redirect_to todos_home_path, notice: 'Letter of Intent has been uploaded.'
    else
      redirect_to todos_home_path, alert: 'Letter of Intent failed to save.'
    end
  end

  def denied
  end

end
