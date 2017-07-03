class Registration < ActiveRecord::Base
  include SummaryMgr, PaymentMgr

  belongs_to :user
  belongs_to :parent
  has_one :loi
  has_many :payments

  validates_uniqueness_of :fname, :scope => :lname, :case_sensitive => false, message: "First and Last name must be unique."
  validates :fname, :lname, :gender, :grade, presence: {message: " is required"}
  validates :scholarship, numericality: true, allow_blank: true
  validates_date :date_of_birth, before: lambda { 1.years.ago }, after: lambda { 30.years.ago }, before_message: "date is too recent", after_message: "date is too old"

  scope :search, lambda {|term|
    term = "%#{term}%"
    where('fname like ? or lname like ?', term, term).order(:lname, :fname)
  }

  # Needs to move to a helper
  def date_of_birth_formatted
    unless date_of_birth.nil?
      date_of_birth.strftime("%m/%d/%Y")
    end
  end

  private

end
