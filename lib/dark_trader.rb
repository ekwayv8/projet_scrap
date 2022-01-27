require 'pry'
require 'dotenv'
require 'rubygems'
require 'nokogiri'
require 'open-uri'

Dotenv.load('.env')

def get_data

	page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))   

end


def extraction_symbol(market_cap)
	
	crypto_name_array = []
	#téléchargement de l'ensemble des symboles
	crypto_fullname_array = market_cap.xpath('/html/body/div/div[1]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr')

	# conservation du texte
	n = 0
	crypto_fullname_array.each do |string|
		ticker = string.xpath('./td[3]/div').text
		
		    if ticker != ""
	      crypto_name_array << ticker
	      	n += 1
	    	else 
	      	n += 1
    	end
  	end
	puts crypto_name_array

	return crypto_name_array
end

def extraction_price(price_value)
	
	crypto_price_array = []	

	#Téléchargement de l'ensemble des prix
	crypto_fullprice_array = price_value.xpath('/html/body/div/div[1]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr')


	# conservation des prix
	j = 0

	  crypto_fullprice_array.each do |crypto_value|
	    price = crypto_value.xpath('./td[5]/div/a').text
	      
	    if price != ""
	      crypto_price_array << price
	      j += 1
	    else
	      j += 1
	    end
	end

	
	#crypto_price_array = crypto_fullprice_array.map { |price| price.text  }
		
puts crypto_price_array
	return crypto_price_array

end



def crypto(crypto_name_array, crypto_price_array)

	#Création de l'array final (contenant les hashes)
	crypto_array = []

	crypto_name_array.each do |symbol|

	result = { symbol => crypto_price_array[crypto_name_array.index(symbol)] }
	    crypto_array << result

	 end

	  return crypto_array

end



def perform

	page = get_data
	crypto_name_array = extraction_symbol(page)
	crypto_price_array = extraction_price(page)
	extraction_price(page)
	extraction_symbol(page)
	crypto_array = crypto(crypto_name_array,crypto_price_array)
	
	puts  "Vous avez collectés #{crypto_array.size} entrées tickers + prix"

	
	crypto_array
end

perform


