require 'html_to_pdf_conversion'
require 'dotenv'

Dotenv.load

@client = PDFlayer::Client.new(ENV['ACCESS_KEY'], ENV['SECRET_KEY'])
response = @client.convert('http://apilayer.net', { export: File.join('tmp', SecureRandom.uuid() +'.pdf') })