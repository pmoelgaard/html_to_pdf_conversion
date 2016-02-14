require 'digest'
require "httparty"
require "html_to_pdf_conversion/version"

module PDFlayer

  class Client

    include HTTParty

    base_uri 'api.pdflayer.com/api'

    def initialize(access_key, secret_key)
      @access_key = access_key
      @secret_key = secret_key
    end

    def convert(document_url, options = {})

      md5 = Digest::MD5.new
      md5.update document_url + @secret_key

      @options = {
          query: {
              access_key: @access_key,
              document_url: document_url,
              secret_key: md5.hexdigest
          },
          export: options[:export]
      }

      begin

        res = self.class.get('/convert', @options)
        res.inspect

        if @options[:export]
          filename = @options[:export]
          begin
            File.open(filename, 'a+') do |file|
              file.write(res.body)
            end
          end
        end

        return res.parsed_response

      rescue => e
        puts e.inspect

      ensure

        @options = nil

      end
    end
  end
end
