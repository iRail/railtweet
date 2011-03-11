class Tracking < ActiveRecord::Base
  
  def self.do_simple_tracking(do_schedule = false)
    self.update_connections
    self.update_stations
    OneWayTrip.all.each { | one_way_trip|
        self.update_departure_delays_via_lifebooard_station(one_way_trip.from_station)
        puts "-----------------------------------------------"
      }
    if do_schedule
      self.send_at(Time.now + 2.minutes, :do_simple_tracking, true)
    end
  end
  
  def self.update_departure_delays_via_lifebooard_station(station)
    station_data = IrailApi.liveboard_station(station.name_nl)
    departures_list = station_data["departures"]["departure"]
    if departures_list
      departures_list.each { |departure_data|
          delay = departure_data["delay"].to_i
          has_left = departure_data["left"] == "1"
          train_number = departure_data["vehicle"].split(".").last.match(/\d+/)[0]
          departure_time = Time.at(departure_data["time"].to_i)
          platform = departure_data["platform"]
          destination_station_name = departure_data["station"]
          self.vehicle_stop_update(station, destination_station_name, train_number, departure_time.to_date, departure_time, nil, delay, has_left, platform)
        }
      end
    #puts station_data.to_yaml
    nil
  end
  
  def self.vehicle_stop_update(station, destination_station_name, vehicle_train_number, stop_date, departure_time, arrival_time, delay, has_left, platform)
    vehicle = Vehicle.where(:train_number=>vehicle_train_number).first
    if vehicle
      vehicle_stop = VehicleStop.where(:station_id=>station, :vehicle_id=>vehicle, :stop_date => stop_date).first
      if vehicle_stop
        # update VehicleStopDelay when #has_left
        unless vehicle_stop.has_left == has_left and vehicle_stop.actual_delay == delay and vehicle_stop.actual_platform == platform and ((not departure_time) or vehicle_stop.departure_time == departure_time) and ((not arrival_time) or vehicle_stop.arrival_time == arrival_time) 
          # create VehicleStopDelay
          vehicle_stop_delay = VehicleStopDelay.new
          vehicle_stop_delay.vehicle_stop   = vehicle_stop
          vehicle_stop_delay.delay          = delay
          vehicle_stop_delay.has_left       = has_left
          vehicle_stop_delay.platform       = platform
          vehicle_stop_delay.source         = "irail.lifebooard"
          vehicle_stop_delay.save
          # update VehicleStop
          vehicle_stop.actual_delay = delay
          vehicle_stop.has_left = has_left
          vehicle_stop.actual_platform = platform
          vehicle_stop.departure_time = departure_time if departure_time
          vehicle_stop.arrival_time = arrival_time if arrival_time
          vehicle_stop.save
          puts "UPDATE #{station.name_nl} -> #{destination_station_name} (#{vehicle.train_number}) #{departure_time.try(:to_s, :short)} --- #{vehicle_stop.vehicle.complete_number } : #{delay} - #{platform} - #{has_left}"
        else
          puts "#{station.name_nl} -> #{destination_station_name} (#{vehicle.train_number}) #{departure_time.try(:to_s, :short)} --- #{vehicle_stop.vehicle.complete_number } : #{delay} - #{platform} - #{has_left}"
        end
      else
        puts "wrong"
      end
    else
      puts "-> #{destination_station_name} (#{vehicle_train_number}) #{departure_time.try(:to_s, :short)} :#{delay} - #{platform} - #{has_left}"
    end
  end
  
  def self.update_connections
    one_way_trips = OneWayTrip.all
    one_way_trips.each { |one_way_trip|
        self.one_way_trip_update_connections one_way_trip
      }
  end
  
  def self.one_way_trip_update_connections(one_way_trip)
    connections = IrailApi.connections(one_way_trip.from_station.name_nl, one_way_trip.to_station.name_nl )
    connection_list = connections["connection"]
    puts "----------------------------------"
    puts one_way_trip.name
    puts connection_list.to_yaml
    connection_list.each { |connection_data|
        unless connection_data["vias"]
          departure_data = connection_data["departure"]
          departure = self.vehicle_stop_create(departure_data, 'departure_time=')
          arrival_data = connection_data["arrival"]
          arrival = self.vehicle_stop_create(arrival_data, 'arrival_time=')
          if departure and arrival
            connection = Connection.find_or_initialize_by_one_way_trip_id_and_departure_id_and_arrival_id(one_way_trip.id, departure.id, arrival.id)
            connection.save
          end
        end
      }
  end
  
  def self.vehicle_stop_create(stop_data, time_method)
    # create or find vehicle
    vehicle_complete_number = stop_data["vehicle"]
    vehicle_train_number = vehicle_complete_number.split(".").last.match(/\d+/)[0]
    if vehicle = Vehicle.find_or_initialize_by_train_number(vehicle_train_number)
      vehicle.complete_number = vehicle_complete_number
      vehicle.save
      # find station
      if station = Station.any_name(stop_data["station"]).first
        # find date & time
        stop_time = Time.at(stop_data["time"].to_i)
        stop_date = stop_time.to_date
        # create of find stop
        #puts "-- #{time_method} - #{vehicle.train_number} - #{station.code} - #{stop_time}"
        vehicle_stop = VehicleStop.find_or_initialize_by_vehicle_id_and_station_id_and_stop_date(vehicle.id, station.id, stop_date)
        platform_data = stop_data["platform"]
        if platform = platform_data["normal"]
          vehicle_stop.platform = platform
        else
          vehicle_stop.platform = platform_data
        end
        vehicle_stop.try(time_method, stop_time)
        vehicle_stop.save
        vehicle_stop
      else
        puts "-> did not find station: #{stop_data["station"]}"
      end
    else
      puts "-> did not find vehicle: #{vehicle_train_number}"
    end
  end
  
  def self.update_stations(force = false)
    unless force
      vehicles = Vehicle.where(:from_station_id => nil)
    else
      vehicles = Vehicle.scoped
    end
    vehicles.each { |vehicle|
      self.vehicle_update_stations vehicle
      }
  end
  
  def self.vehicle_update_stations(vehicle)
    vehicle_data = IrailApi.vehicle(vehicle.complete_number)
    station_list = vehicle_data["stops"]["stop"]
    #puts station_list.to_yaml
    if vehicle_data["stops"]["number"].to_i > 1
      vehicle.from_station = Station.any_name(station_list.first["station"]).try :first
      vehicle.to_station = Station.any_name(station_list.last["station"]).try :first
      departure_time = Time.at(station_list.first["time"].to_i)
      vehicle.departure_hour = departure_time.hour
      vehicle.departure_min = departure_time.min
      vehicle.number_of_stops =  vehicle_data["stops"]["number"].to_i
      vehicle.save
      vehicle
    else
      puts "no return for vehicle #{vehicle.complete_number} "
    end
  end
  
end
