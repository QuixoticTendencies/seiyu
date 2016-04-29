require 'rubygems'
require 'nokogiri'
require 'open-uri'

seiyuurl = ARGV[0]
un = ARGV[1] || 'default_user'

seiyu = Nokogiri::HTML(open(seiyuurl))
mal = Nokogiri::XML(open('http://myanimelist.net/malappinfo.php?u=' + un + '&status=all&type=anime'))
seiyu_shows = seiyu.css('table:nth-child(4) .borderClass:nth-child(2) > a')
seiyu_roles = seiyu.css('.borderClass~ .borderClass+ .borderClass > a')
mal_shows = mal.xpath("//series_title")
seiyu_shows_ar = Array.new()
seiyu_roles_ar = Array.new()
mal_shows_text = Array.new()
for i in 0..(seiyu_shows.length - 1) do
	seiyu_shows_ar[i] = seiyu_shows[i].text
	seiyu_roles_ar[i] = seiyu_roles[i].text
end
for i in 0..(mal_shows.length - 1) do
	mal_shows_text[i] = mal_shows[i].text
end
seiyu_hash = Hash[seiyu_shows_ar.zip(seiyu_roles_ar)]
noncolliding_shows = seiyu_shows_ar - mal_shows_text
colliding_shows = seiyu_shows_ar - noncolliding_shows
output = Array.new()
for i in 0..(colliding_shows.length - 1) do
	output[i] = colliding_shows[i] + ' - ' + seiyu_hash[colliding_shows[i]]
end

if un == 'default_user' then
	for i in 0..(seiyu_shows_ar.length - 1) do
		output[i] = seiyu_shows_ar[i] + ' - ' + seiyu_roles[i]
	end
end
puts output.join("\n")
