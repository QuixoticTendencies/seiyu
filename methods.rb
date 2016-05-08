require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'

seiyuurl = ARGV[0] || 'http://myanimelist.net/people/28/Yui_Horie'
un = ARGV[1] || 'quixten'


seiyu = Nokogiri::HTML(open(seiyuurl), nil, 'utf-8')
mal = Nokogiri::XML(open('http://myanimelist.net/malappinfo.php?u=' + un + '&status=all&type=anime'))
seiyu_shows = seiyu.css('table:nth-child(4) .borderClass:nth-child(2) > a').to_a.map(&:text)
seiyu_roles = seiyu.css('.borderClass~ .borderClass+ .borderClass > a').to_a.map(&:text)
mal_shows = mal.xpath("//series_title").to_a.map(&:text)

seiyu_hash = Hash[seiyu_shows.zip(seiyu_roles)]
noncolliding_shows = seiyu_shows - mal_shows
colliding_shows = seiyu_shows - noncolliding_shows
output = Array.new()
for i in 0..(colliding_shows.length - 1) do
	output[i] = colliding_shows[i] + ' - ' + seiyu_hash[colliding_shows[i]]
end


if un == 'default_user' then
	for i in 0..(seiyu_shows.length - 1) do
		output[i] = seiyu_shows[i] + ' - ' + seiyu_roles[i]
	end
end
puts output.join("\n")
