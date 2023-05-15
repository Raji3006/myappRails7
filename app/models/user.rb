class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
         
  validates :username, format: { without: /\W/, message: "only allows letters, numbers, and underscores" }
  validates :phone_number, presence: true, numericality: { only_integer: true }, length: { is: 10 }
  validates :pincode, numericality: { only_integer: true }, length: { is: 6 }

  has_many :messages
end
