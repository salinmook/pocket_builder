class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :stores, dependent: :destroy

  def owner?
    role == "owner"
  end

  def customer?
    role == "customer"
  end
end
