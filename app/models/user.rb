class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :listings

  validates :name, presence: true
  validates_format_of :zip_code,
    :with => /\A(\d{5}\z)|(\d{5}-\d{4}\z)/, presence: true
end
