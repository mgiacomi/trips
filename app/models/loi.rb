class Loi < ActiveRecord::Base

  belongs_to :user
  belongs_to :registration

  validates :p1name, :p1phone, :p1email, :p1address, :p1signature, :p1understand, :p1relationship, :p1sigdate, presence: {message: " is required"}
  validates :p2name, :p2phone, :p2email, :p2address, :p2signature, :p2understand, :p2relationship, :p2sigdate, presence: {message: " is required"}, :if => :signed_sig2
  validates_date :p1sigdate, before: lambda {2.days.from_now}, after: lambda {2.days.ago}, before_message: "date is too recent", after_message: "date is too old"

  # Needs to move to a helper
  def p1sigdate_formatted
    unless p1sigdate.nil?
      p1sigdate.strftime("%m/%d/%Y")
    end
  end

  def p1_signature_accepted
    !self.p2name.blank? || !self.p2phone.blank? || !self.p2email.blank? || !self.p2address.blank? ||
        !self.p2signature.blank? || !self.p2understand.blank? || !self.p2relationship.blank? || !self.p2sigdate.blank?
  end

  private

  def signed_sig2
    !self.p2name.blank? || !self.p2phone.blank? || !self.p2email.blank? || !self.p2address.blank? ||
        !self.p2signature.blank? || !self.p2understand.blank? || !self.p2relationship.blank? || !self.p2sigdate.blank?
  end

end
