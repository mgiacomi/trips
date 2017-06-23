class Parent < ActiveRecord::Base

  belongs_to :user

  validates :p1fname, :p1lname, :p1street, :p1city, :p1state, :p1zip, :p1email, :p1phone, presence: {message: " is required"}

  scope :search, lambda {|term|
    term = "%#{term}%"
    where('p1fname like ? or p1lname like ? or p2fname like ? or p2lname like ? or p1email like ? or p2email like ?', term, term, term, term, term, term).order(:slname, :sfname)
  }

  private

end
