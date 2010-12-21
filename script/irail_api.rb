require 'active_support'
require 'net/http'
require 'net/smtp'

class IrailApi
 def send_mail(body, email_alias, email)

msg = <<END_OF_MESSAGE
From: RailTweet <railtweet@link42.net>
To: #{email_alias} <#{email}>
Subject: RailTweet found a train with delay
	
#{body}
END_OF_MESSAGE
	
   Net::SMTP.start('smtp.skynet.be') do |smtp|
     smtp.send_message msg, "railtweet@link42.net", email
   end
 end

 def is_duplicate(arrival_delay, departure_delay, message, email_alias, email)
  filename = email_alias.tr(' ', '_').concat('.txt').concat(message.sum.to_s)
  return true if File.exists?(filename) && IO.read(filename) == message
  File.open(filename, 'w') {|f| f.write(message) } if ((arrival_delay != 0) || (departure_delay != 0))
  false
 end

 def has_delay(response)
   response["connections"]["connection"].detect { |connection| ((connection['arrival']['delay'] != '0') || (connection['departure']['delay'] != '0')) }
 end

 def display_delay(response, email_alias, email)
  response["connections"]["connection"].each do |connection|
   arrival_delay = connection['arrival']['delay'].to_i / 60
   arrival_station = connection['arrival']["station"]
   departure_delay = connection['departure']['delay'].to_i / 60
   departure_station = connection['departure']["station"]
   departure_time = Time.at(connection['departure']['time'].to_i)
   message = "DELAY FOUND! #{departure_station} -> #{arrival_station} : delay: departure: #{departure_delay} arrival: #{arrival_delay} departure time: #{departure_time}"
   duplicate = is_duplicate(arrival_delay, departure_delay, message, email_alias, email)
   puts "message #{duplicate}"
   if ((arrival_delay != 0) || (departure_delay != 0)) && !duplicate
     puts "sending mail: #{message}"
     send_mail message, email_alias, email
   end
  end
 end

 def check(from, to, email_alias, email)
   base_url = "http://api.irail.be"
   app = "connections"
   request = "?to=#{to}&from=#{from}"
   url = "#{base_url}/#{app}/#{request}"
   resp = Net::HTTP.get_response(URI.parse(url))
   data = resp.body
   #puts "response we got from the net:"
   #puts data

   result = Hash.from_xml data
   #puts result
   connection_has_delay = has_delay(result)
   display_delay(result, email_alias, email) if connection_has_delay
 end
end

railtweet = IrailApi.new
railtweet.check("BRUGGE", "OOSTENDE", "Bart De Gruyter", "bdg@pobox.com")
railtweet.check("JETTE", "GROENENDAAL", "Bart De Gruyter", "bdg@pobox.com")
railtweet.check("GROENENDAAL", "JETTE", "Bart De Gruyter", "bdg@pobox.com")
#railtweet.check("ANTWERPEN", "BRUSSEL-CENTRAAL", "Dimitri Van de Putte", "dimitri.vandeputte@me.com")
#railtweet.check("BRUSSEL-CENTRAAL", "ANTWERPEN", "Dimitri Van de Putte", "dimitri.vandeputte@me.com")
