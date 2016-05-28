require 'nokogiri'
require 'open-uri'

doc = Nokogiri::HTML(open("http://115.84.164.178/seoulmap/populationReport.jsp?paramcode=13-202"))
doc.css('#highcharts-0').each do |a|
	puts a
end
