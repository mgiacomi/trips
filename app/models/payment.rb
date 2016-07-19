class Payment < ActiveRecord::Base

  belongs_to :registration
  belongs_to :user

  validates :amount, numericality: true, allow_blank: true

  class << self
  end

end
