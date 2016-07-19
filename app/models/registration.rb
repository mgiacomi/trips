class Registration < ActiveRecord::Base
  include LoiFileMgr, SummaryMgr

  belongs_to :user
  has_many :payments

  validates :sfname, :slname, :sgender, :grade, presence: {message: " is required"}
  validates :p1fname, :p1lname, :street, :city, :state, :zip, :p1email, :p1phone, presence: {message: " is required"}
  validates :scholarship, numericality: true, allow_blank: true

  scope :search, lambda {|term|
    term = "%#{term}%"
    where('sfname like ? or slname like ? or p1fname like ? or p1lname like ? or p1email like ?', term, term, term, term, term)
  }

  #scope :uploaded_loi, lambda {|grade| where('file_name is not null and grade = ?', grade) }
  #scope :registered, lambda {|grade| where('grade = ?', grade) }

  private

end
