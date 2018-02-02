require 'bundler/setup'
require "fxrates/version"
require 'date'
require 'json'


=begin
module Fxrates
  # Your code goes here...
end
=end 

class ExchangeRate

	#Returns the FX data for the date given in @date.
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


	#Returns the exchange rate for the curency given in @currency from the data given in @data.
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


	#Returns the exchange rate from @base to @counter on @date.
	def at(date,base,counter)
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

	#Converts @amount in @base into its eqivelent in @counter on @date. 
	def calcTotal(date,amount,base,counter)
		return amount * at(date,base,counter)
	end


end



