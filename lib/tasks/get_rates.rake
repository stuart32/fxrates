

desc 'update rates'
task update_rates: :lib do
  # ... set options if any



require 'json'

		puts "Updating euro forign exchange refrence rates: " + Time.now.strftime("%d/%m/%Y %H:%M") 
  		response = Crack::XML.parse(File.read(open("http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml")))
	 	File.open(Dir.pwd + "/rates.json","w") do |f|
  		f.write(JSON.pretty_generate(response))
  	end
end