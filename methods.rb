require 'rubygems'
require 'nokogiri'
require 'open-uri'

page = Nokogiri::HTML(open("http://myanimelist.net/people/599/Aki_Toyosaki"))
shows = page.css('table:nth-child(4) .borderClass:nth-child(2) > a')
roles = page.css('.borderClass~ .borderClass+ .borderClass a')
