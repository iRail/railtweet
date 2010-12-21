class IrailApi
 def self.run()
   base_url = "http://api.irail.be"
   app = "connections"
   request = "?to=GROENENDAAL&from=BRUSSEL-SCHUMAN"
   url = "#{base_url}/#{app}/#{request}"
   resp = Net::HTTP.get_response(URI.parse(url))
   data = resp.body
   puts "response we got from the net:"
   puts data

   result = Hash.from_xml data
   puts result

   #result = REXML::Document.new(data)
   #puts "result from parsing the XML:"
   #puts result

   return result
 end
end