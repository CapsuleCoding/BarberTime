class User < ApplicationRecord
  has_many :clients 
  has_many :barbers, through: :clients 
  has_many :timeslots, through: :clients
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

    def self.from_google(uid:, email:, full_name:, avatar_url:)
    user= User.find_or_create_by(email: email) do |u|
      u.uid = uid
      u.full_name = full_name
      u.avatar_url = avatar_url
      u.password = SecureRandom.hex
    end
    user.update(uid: uid, full_name: full_name, avatar_url: avatar_url)
  end
end

