require 'securerandom'
require 'dotenv'
require 'spec_helper'
require 'html_to_pdf_conversion'

# Load Environment Variables
Dotenv.load

RSpec.configure do |c|
  # declare an exclusion filter
  c.filter_run_excluding :ci => ENV['CONTEXT'] == 'travis-ci'
end

describe PDFlayer do


  it 'has a version number' do
    expect(PDFlayer::VERSION).not_to be nil
  end


  it 'convert (simple)' do

    begin

      # Declare the Client instance passing in the authentication parameters
      @client = PDFlayer::Client.new(ENV['ACCESS_KEY'], ENV['SECRET_KEYWORD'])

      # Set the URL to get as PDF, we take a random URL from Wikipedia
      document_url = 'https://en.wikipedia.org/wiki/Special:Random'

      # We declare the options
      options = PDFlayer::ConvertOptions.new()

      # We make the call to convert
      response = @client.convert(document_url, options)

      # First we check the response
      expect(response).not_to be nil

    rescue => e
      puts e.inspect

    end

  end


  it 'convert (simple) w. export', :ci => true do

    begin

      # Declare the Client instance passing in the authentication parameters
      @client = PDFlayer::Client.new(ENV['ACCESS_KEY'], ENV['SECRET_KEYWORD'])

      # Set the URL to get as PDF, we take a random URL from Wikipedia
      document_url = 'https://en.wikipedia.org/wiki/Special:Random'

      # We declare the options
      options = PDFlayer::ConvertOptions.new()

      # We then set the export option
      options.export = File.join('tmp', SecureRandom.uuid() +'.pdf')

      # We make the call to convert
      response = @client.convert(document_url, options)

      # First we check the response
      expect(response).not_to be nil

      # Then we check if the file exists has been successfully written to disk
      file_exists = File.exist?(options.export)
      expect(file_exists).to be true

    rescue => e
      puts e.inspect

    ensure
      # Clean up after the test and remove the file from disk
      File.delete(options.export);

    end

  end

end




