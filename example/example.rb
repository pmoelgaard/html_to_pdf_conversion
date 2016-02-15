require 'html_to_pdf_conversion'
require 'dotenv'

# Load Environment Variables
Dotenv.load

# Declare the Client instance passing in the authentication parameters
@client = PDFlayer::Client.new(ENV['ACCESS_KEY'], ENV['SECRET_KEY'])

# Set the URL to get as PDF, we take a random URL from Wikipedia
document_url = 'https://en.wikipedia.org/wiki/Special:Random'

# We declare the options
options = PDFlayer::ConvertOptions.new()
options.export = File.join('tmp', SecureRandom.uuid() +'.pdf')

# We make the call to convert
response = @client.convert(document_url, options)

# If its a success, we print a message to the user
if ! response.nil?
  puts 'SUCCESS : PDF fetched...'
end