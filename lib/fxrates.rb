require 'bundler/setup'
require "fxrates/version"
require 'open_uri_redirections'
require 'crack'
require 'crack/xml'
require 'date'
require 'json'


class ExchangeRate
	#Stores fx data from ECB to db/rates.json
	def getRates
		response = Crack::XML.parse(File.read(open("http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml")))
	 	File.open(Dir.pwd + "/db/rates.json","w") do |f|
  		f.write(JSON.pretty_generate(response))
  		end
  	end

	#Returns the FX data for the date given in @date.
	def getRatesFromDate(date)
		file = File.read('../db/rates.json')
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
				raise "#{currency} is not a valid currency"
			end	
	end



	#Returns each curreny three letter refrence for a given date with 'EUR' added.
	def getCurrenciesFromDate( date)
		cur = Array.new
		cur[1] = 'EUR';
		data = getRatesFromDate(date)
		for t in data
			cur.push(t['currency'].to_s)
		end
		return cur
	end



	#Returns the exchange rate from @base to @counter on @date.
	def at(date,base,counter)
		data = getRatesFromDate(date)
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

r = ExchangeRate.new

s = r.calcTotal("2018-01-26", 100, "GBP", "HUF")
puts s

t = r.getCurrenciesFromDate("2018-01-26")

puts t


