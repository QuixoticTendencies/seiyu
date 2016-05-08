begin
	require 'rubygems'
	require 'nokogiri'
	require 'open-uri'

	seiyu_url = ARGV[0] || 'default_seiyu'
	user_name = ARGV[1] || 'default_user'

	if seiyu_url != 'default_seiyu'
		seiyu = Nokogiri::HTML(open(seiyu_url), nil, 'utf-8')
	end
	mal = Nokogiri::XML(open('http://myanimelist.net/malappinfo.php?u=' + user_name + '&status=all&type=anime'))

	def seiyu_main(user_name, seiyu_url, seiyu, mal)
		if seiyu_url != 'default_seiyu'
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
		end
		if user_name == 'default_user'
			if seiyu_url == 'default_seiyu'
				output = 'You have input neither a voice actor nor a user to lookup. The program will exit.'
			else
				for i in 0..(seiyu_shows.length - 1) do
					output[i] = seiyu_shows[i] + ' - ' + seiyu_roles[i]
				end
				output = [ 'You have input a voice actor but not a user. The program will output the voice actor\'s entire role list.', output]
			end
		end
		return output
	end

	output = seiyu_main(user_name, seiyu_url, seiyu, mal)
		output = output || ['An unknown error has ocurred. No output is possible. The program will exit.']
		puts output.join("\n")
rescue
	puts 'Usage:'
	puts '    $ ruby seiyu.rb <seiyu url> <user name>' + "\n"
	puts 'Example:'
	puts '    $ ruby seiyu.rb http://myanimelist.net/people/557/Masako_Nozawa some_user'
end
