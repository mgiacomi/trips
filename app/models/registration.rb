class Registration < ActiveRecord::Base
  include SummaryMgr, PaymentMgr

  belongs_to :user
  has_many :payments

  validates :fname, :lname, :gender, :grade, presence: {message: " is required"}
  validates :scholarship, numericality: true, allow_blank: true
  validates_date :date_of_birth, before: lambda { 5.years.ago }, after: lambda { 30.years.ago }, before_message: "date is too recent", after_message: "date is too old"

  scope :search, lambda {|term|
    term = "%#{term}%"
    where('fname like ? or lname like ?', term, term).order(:lname, :fname)
  }

  private

end
