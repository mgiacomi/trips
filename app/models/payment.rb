class Payment < ActiveRecord::Base

  belongs_to :registration

  validates :amount, numericality: true, allow_blank: true

  class << self
  end

end
