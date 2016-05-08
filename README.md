# seiyu
Command line helper tool for knowing where you might have heard a voice actor before. Interfaces with MyAnimeList.net

## Note
This program expects Ruby version 2.0.0. Other versions may work, but results are not guaranteed.

## Installation
`$ cd ~`  
`$ git clone https://github.com/QuixoticTendencies/seiyu.git`  
`$ echo '#!/PATH/TO/RUBY'|cat - ~/seiyu/seiyu.rb > /tmp/out && mv /tmp/out ~/seiyu/seiyu.rb`  
`$ chmod +x ~/seiyu/seiyu.rb`  

## Usage
`$ seiyu.rb [path to myanimelist seiyu page] [myanimelist username]`  

## Example
`$ seiyu.rb http://myanimelist.net/people/557/Masako_Nozawa quixten`
