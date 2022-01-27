require 'pry'
require 'dotenv'
require 'rubygems'
require 'nokogiri'
require 'open-uri'

Dotenv.load('.env')

def get_data

	page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))   

end


def extraction_symbol(page)
	
	crypto_name_array = []
	#téléchargement de l'ensemble des symboles
	crypto_fullname_array = page.xpath('/html/body/div/div[1]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr')


	# conservation du texte
	i = 0
	crypto_fullname_array.each do |string|
		ticker = string.xpath('./td[3]/div').text
		
	    if ticker != ""
      crypto_name_array << ticker
      	i += 1
    	else 
      	i += 1
    end
  end
	puts crypto_name_array

	return crypto_name_array

end

def extraction_price(page)
	

	#Téléchargement de l'ensemble des prix
	crypto_fullprice_array = page.xpath('//*[@id]/td[5]/a')


	# conservation des prix
	crypto_price_array = crypto_fullprice_array.map { |price| price.text  }
		

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
	
	puts  "Vous avez collectés #{crypto_array.size} entrées"

	
	crypto_array
end

perform


