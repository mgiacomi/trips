class Registration < ActiveRecord::Base
  include LoiFileMgr, SummaryMgr

  belongs_to :user
  has_many :payment

  validates :sfname, :slname, :sgender, :grade, presence: {message: " is required"}
  validates :p1fname, :p1lname, :street, :city, :state, :zip, :p1email, :p1phone, presence: {message: " is required"}
  validates :scholarship, numericality: true, allow_blank: true

  #scope :outstanding_loi, lambda {|grade| where('file_name is null and grade = ?', grade) }
  #scope :uploaded_loi, lambda {|grade| where('file_name is not null and grade = ?', grade) }
  #scope :registered, lambda {|grade| where('grade = ?', grade) }

  private

end
