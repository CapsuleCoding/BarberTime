class Client < ApplicationRecord
  belongs_to :user
  has_many :timeslots
  has_many :barbers, through: :timeslots
  
  validates :name, presence: true, uniqueness: {scope: :user_id}
end
