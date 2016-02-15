require 'securerandom'
require 'dotenv'
require 'spec_helper'
require 'html_to_pdf_conversion'

# Load Environment Variables
Dotenv.load

describe PDFlayer do

  it 'has a version number' do
    expect(PDFlayer::VERSION).not_to be nil
  end

  # it 'validates required access_key parameter for client' do
  #   begin
  #     @client = PDFlayer::Client.new()
  #   rescue => e
  #     expect(e.argument).equals('access_key')
  #   end
  # end
  #
  # it 'validates required secret_key for client' do
  #   begin
  #     @client = PDFlayer::Client.new('defunct_access_key')
  #   rescue => e
  #     expect(e.argument).equals('secret_key')
  #   end
  # end

  # it 'checks for exported file' do
  #
  #   begin
  #
  #     # Declare the Client instance passing in the authentication parameters
  #     @client = PDFlayer::Client.new()
  #
  #     # Set the URL to get as PDF, we take a random URL from Wikipedia
  #     document_url = 'https://en.wikipedia.org/wiki/Special:Random'
  #
  #     # We declare the options
  #     options = PDFlayer::ConvertOptions.new()
  #     options.export = File.join('tmp', SecureRandom.uuid() +'.pdf')
  #
  #     # We make the call to convert
  #     response = @client.convert(document_url, options)
  #
  #     expect(response).not_to be nil
  #
  #   rescue => e
  #     puts e.inspect
  #
  #   ensure
  #     # Clean Up
  #
  #   end
  #
  # end

end




