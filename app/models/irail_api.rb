class IrailApi 
 def self.call(app, parameters)
   base_url = "http://api.irail.be"
   request_url = "?format=json&#{parameters.to_query}" 
   url = "#{base_url}/#{app}/#{request_url}"
   resp = Net::HTTP.get_response(URI.parse(url))
   JSON.parse(resp.body)
 end
 
 def self.connections(from_station_name, to_station_name)
   self.call "connections", {:from=>from_station_name, :to=>to_station_name}
 end
 
 def self.liveboard_station(station_name)
   track_time = Time.now - 5.minutes
   time = "#{"%02d" % track_time.hour}#{"%02d" % track_time.min}"
   date = "#{"%02d" % track_time.day}#{"%02d" % track_time.month}#{track_time.year.to_s[2,2]}"
   self.call "liveboard", {:station=>station_name, :time => time, :date => date }
 end
 
 def self.vehicle(vehicle_name)
   self.call "vehicle", {:id=>vehicle_name }
 end
end