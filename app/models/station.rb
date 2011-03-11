class Station < ActiveRecord::Base
  has_many :vehicle_stops
  
  scope :any_name, lambda { |name| 
    check = "%#{name}%"
    where("name_nl like ? or name_fr like ? or name_en like ?", check, check, check) 
    }
  search_methods :any_name
  
  validates :code, :uniqueness => true
  validates :name_nl, :presence => true
  validates :name_fr, :presence => true
  validates :name_en, :presence => true
  
  def self.get_stations_from_irail
    base_url = "http://api.irail.be"
    app = "stations"
    url = "#{base_url}/#{app}/"
    resp = Net::HTTP.get_response(URI.parse(url))
    data = resp.body
    result = Hash.from_xml data
    return result
  end
  
  def self.load_stations_from_irail
    stations = get_stations_from_irail['stations']['station']
    stations.each { | station | 
      self.create_from_name station
      }
  end
  
  def self.load_stations_from_file
    f = File.new("config/stations.csv", "r")
    f.each { |line|
      fields = line.split(";")
      puts "#{fields[0]} - #{fields[2]}"
      create_from_fields(fields)
      }
    f.close
  end
  
  def self.create_from_fields(fields)
    unless fields[0].blank?
      code = fields[0]
      if station = Station.where(:code=>code).first
        station.code_nmbs = fields[1]
        station.name_nl = fields[2]
        station.name_fr = fields[3]
        station.name_en = fields[4]
        station.region = fields[5]
        station.save
      else
        create! do |station|
          station.code = fields[0]
          station.code_nmbs = fields[1]
          station.name_nl = fields[2]
          station.name_fr = fields[3]
          station.name_en = fields[4]
          station.region = fields[5]
        end
      end
    end
  end
  
  def self.select(language)
    scoped.order("name_#{language} asc")
  end
  
  def self.publish_flat
    f = File.new("config/stations.txt", "w")
    self.scoped.each { |station|
        f << "#{station.name}, #{station.abbreviation}, #{station.language}\n"
      }
    f.close
  end
end
