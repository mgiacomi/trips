class Registration < ActiveRecord::Base
  include LoiFileMgr

  belongs_to :user
  has_many :payment

  validates :sfname, :slname, :sgender, :grade, presence: {message: " is required"}
  validates :p1fname, :p1lname, :street, :city, :state, :zip, :p1email, :p1phone, presence: {message: " is required"}
  validates :scholarship, numericality: true, allow_blank: true

  class << self
  end

  private

end
