class Timeslot < ApplicationRecord
    belongs_to :barber
    belongs_to :client
  
    validates :start_time, :end_time, :address, presence: true
    validate :barber_unavaible, :client_unavaiable, if: :starts_before_it_ends?
    validate :ends_after_it_starts


    def barber_unavaible
      starting = self.start_time
      ending = self.end_time
      conflict = barber.timeslots.any? do |timeslot|  #.any = Returns true if at least one element is true (or non empty array)
        other_start = timeslot.starting_date_and_time
        other_end = timeslot.ending_date_and_time 
        other_start < ending && ending < other_end || other_start < starting && starting < other_end 
      end
      if conflict 
        errors.add[:barber, " Timeslot Unavailable"]
      end 
    end
     
    def client_unavaiable 
      starting = self.start_time
      ending = self.end_time
      conflict = client.timeslots.any? do |timeslot|
        other_start = timeslot.starting_date_and_time
        other_end = timeslot.ending_date_and_time 
        other_start < ending && ending < other_end || other_start < starting && starting < other_end
      end
      if conflict 
        errors.add[:client, "Conflicting Timeslot Unavailable"]
      end    
    end
  
    def ends_after_it_starts
      if !starts_before_it_ends?
        errors.add(:start_time, 'must be before the end time')
      end
    end
  
    def starts_before_it_ends?
      start_time < end_time
    end
  
    def barber_name 
      self.barber.name
    end
  
    def client_name 
      self.client.name
    end
  
    #scope method that returns all timeslots that belong to a particular barber.
    def self.by_barber(barber)
      where(barber_id: barber.id)
    end
  
    def self.upcoming
      where("start_time > ?", Time.now)
    end
  
    def self.past 
      where("start_time < ?", Time.now)
    end
  
    def self.most_recent
      order(start_time: :desc)
    end
  
    def self.longest_ago
      order(start_time: :asc)
    end
  
  end
  