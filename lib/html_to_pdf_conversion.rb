require 'digest'
require "httparty"
require "pdflayer/version"

module PDFlayer

  class Client

    include HTTParty

    base_uri 'api.pdflayer.com/api'

    def initialize(access_key, secret_key)
      @access_key = access_key
      @secret_key = secret_key
    end

    def convert(document_url)

      md5 = Digest::MD5.new
      md5.update document_url + @secret_key

      options = {
          query: {
              access_key: @access_key,
              document_url: document_url,
              secret_key: md5.hexdigest
          }
      }

      request = self.class.get('/convert', options)

      begin
        puts request.parsed_response
      rescue => e
        puts "Rescued #{e.inspect}"
      end

    end

  end
end
