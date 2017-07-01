class Loi < ActiveRecord::Base

  belongs_to :user
  belongs_to :parent

  validates :p1name, :p1phone, :p1email, :p1address, :p1signature, :p1understand, :p1relationship, :p1sigdate, presence: {message: " is required"}
  validates :understand, acceptance: { accept: 'Yes, I fully understand and accept this waiver.' }
  validates_date :p1sigdate, before: lambda { 5.days.ago }, after: lambda { 5.days.ago }, before_message: "date is too recent", after_message: "date is too old"

  private

end
