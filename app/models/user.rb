class User < ActiveRecord::Base
  belongs_to :from_station, :class_name => "Station"
  belongs_to :to_station, :class_name => "Station"
  
  belongs_to :way_there, :class_name => "OneWayTrip"
  belongs_to :way_back, :class_name => "OneWayTrip"
  
  before_save :update_activate_tweets
  before_save :update_one_way_trips
  
  #validates :from_station, :presence => true
  #validates :to_station, :presence => true
  validates :way_there_slot_start_hour, :presence => true
  validates :way_there_slot_end_hour  , :presence => true
  validates :way_back_slot_start_hour , :presence => true
  validates :way_back_slot_end_hour   , :presence => true
  validates :way_there_slot_start_min , :presence => true
  validates :way_there_slot_end_min   , :presence => true
  validates :way_back_slot_start_min  , :presence => true
  validates :way_back_slot_end_min    , :presence => true
  validates :delay_tolerance, :presence => true
  
  def self.create_with_omniauth(auth, extra_attributes)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["user_info"]["name"]
      user.nickname = auth["user_info"]["nickname"]
      user.image = auth["user_info"]["image"]
      user.background_image = auth["extra"]["user_hash"]["profile_background_image_url"]
      user.attributes = extra_attributes || self.defaults
    end
  end
  
  def self.defaults
    {
      :way_there_slot_start_hour => 6,
      :way_there_slot_end_hour   => 8,
      :way_back_slot_start_hour  => 16,
      :way_back_slot_end_hour    => 18,
      :way_there_slot_start_min  => 30,
      :way_there_slot_end_min    => 30,
      :way_back_slot_start_min   => 30,
      :way_back_slot_end_min     => 30,
      :tweets_active             => true,
      :include_l                 => false,
      :include_ir                => false,
      :include_ic                => true,
      :delay_tolerance           => 5
    }
  end
  
  def update_activate_tweets
    unless self.from_station and self.to_station
      self.tweets_active = false
    end
  end
  
  def update_one_way_trips
    if from_station and to_station
      # way there
      unless way_there = OneWayTrip.where(:from_station_id => self.from_station.id, :to_station_id => self.to_station.id).first
        way_there = OneWayTrip.new(:from_station => self.from_station, :to_station => self.to_station)
        way_there.save
      end
      self.way_there = way_there
      # way back
      unless way_back = OneWayTrip.where(:from_station_id => self.to_station.id, :to_station_id => self.from_station.id).first
        way_back =  OneWayTrip.new(:from_station => self.to_station, :to_station => self.from_station)
        way_back.save
      end
      self.way_back = way_back
    end
  end
end
