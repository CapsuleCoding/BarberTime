class Barber < ApplicationRecord
  has_many :timeslots
  has_many :clients, through: :timeslots
  
  validates :name, :phone_number, :skills, presence: true
end
