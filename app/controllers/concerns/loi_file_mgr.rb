module LoiFileMgr
  extend ActiveSupport::Concern

  module ClassMethods
  end

  def file_url
    "#{self.file_name}#{self.file_ext}"
  end

  def file
    nil
  end

  def file=(new_file)
    @file = new_file
  end

  included do
    after_save :save_file
    before_save :set_name_and_ext
  end

  private

  def set_name_and_ext
    unless @file.nil?
      self.file_name = @file[:filename].chomp(File.extname(@file[:filename]))
      self.file_ext = File.extname(@file[:filename]).downcase
    end
  end

  def save_file
    unless @file.nil?
      directory = "#{Rails.configuration.loi_file_dir}/"
      FileUtils.mkpath directory
      file_name = "#{self.id}#{self.file_ext}"
      path = File.join(directory, file_name)
      File.open(path, "wb") { |f| f.write(@file[:data]) }
    end
  end

end