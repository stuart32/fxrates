require 'bundler/setup'
require "fxrates/version"
require 'open_uri_redirections'
require 'crack'
require 'crack/xml'
require 'json'


=begin
module Fxrates
  # Your code goes here...
end
=end 

class ExchangeRate

=begin
	def readRates
	 	response = Crack::XML.parse(File.read(open("http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml")))
	 	File.open("rates.json","w") do |f|
  		f.write(JSON.pretty_generate(response))
		end
	end
=end

	#Returns the 
	def getRatesFromTime(date)
		file = File.read('rates.json')
		data = JSON.parse(file)['gesmes:Envelope']['Cube']['Cube']
		found = false
		for t in data
			d1 = Date.parse(t['time'])
			d2 = Date.parse(date)
			if d1 == d2
				found = true
				return t['Cube']
			end
		end
		if found == false 
			raise "No data on #{d2}"
		end
	end



	def getRate(currency, data)
		
			if currency == 'EUR'
				return 1.to_f
			end
			found = false
			for t in data
				if t['currency'].to_s == currency
					found = true
					return t['rate'].to_f
				else
					found = false
				end
			end
			if found == false
				puts "#{currency} is not a valid currency"
			end	
	end



	def at(date,base,counter)
		file = File.read('rates.json')
		data = getRatesFromTime(date)
		rate = getRate(counter,data)
		b = getRate(base, data)
		if b==nil || rate == nil
			puts "Not a valid currency pair"
		else
			if base == 'EUR'
				return rate
			elsif counter.to_s == 'EUR'
				return 1/b
			else
				return getRate(counter,data)/getRate(base,data)
			end
		end
	
	end


	def calcTotal(date,amount,base,counter)
		return amount * at(date,base,counter)
	end


end



