class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :registrations
  has_one :parent

  def super_admin?
    ['mgiacomi@gltech.com','tricia.waineo@oyanokai.org'].include? self.email
  end
end
