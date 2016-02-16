require 'uri'
require 'digest'
require "httparty"
require "hashable"
require "html_to_pdf_conversion/version"
require "html_to_pdf_conversion/missing_argument_exception"

module PDFlayer

  class Client

    include HTTParty

    base_uri 'api.pdflayer.com/api'

    def initialize(access_key, secret_keyword)

      if access_key.nil?
        raise PDFlayer::MissingArgumentException.new 'access_key'
      end

      if secret_keyword.nil?
        raise PDFlayer::MissingArgumentException.new 'secret_keyword'
      end

      @access_key = access_key
      @secret_keyword = secret_keyword

    end


    def convert(document_url, options = {})

      if document_url.nil?
        raise PDFlayer::MissingArgumentException.new 'document_url'
        return
      end

      # Create a shallow copy so we don't manipulate the original reference
      query = options.dup

      # Generate the SecretKeyword for the request
      md5 = Digest::MD5.new
      md5.update document_url + @secret_keyword
      secret_key = md5.hexdigest

      # Populate the Query
      query.access_key = @access_key
      query.secret_key = secret_key
      query.document_url = URI.escape(document_url)

      # We then create the Request
      req = ConvertRequest.new(query)

      #  We create a Hash of the request so we can send it via HTTP
      req_dto = req.to_dh

      begin

        # We make the actual request
        res = self.class.get('/convert', req_dto)

        # We ensure that we tap the response so we can use the results
        res.inspect

        # If we have an export option passed in, we save it to local file system
        if options.export.nil?

          # We just return the parsed binary response
          return res.parsed_response

        else

          begin

            File.open(options.export, 'a+') do |file|

              file.write(res.body)

              result = {
                  success: true,
                  info: "The PDF file has been saved to your local file system",
                  file_name: options.export
              }
              return result

            end

          end
        end


      rescue => e
        puts e.inspect
        return

      ensure
        # Clean Up

      end
    end
  end


  class ConvertRequest

    include Hashable

    attr_accessor :query

    def initialize(query = {})
      self.query = query;
    end

  end


  class ConvertOptions

    include Hashable

    attr_accessor :access_key
    attr_accessor :secret_key

    attr_accessor :document_url
    attr_accessor :document_html

    attr_accessor :document_name
    attr_accessor :export
    attr_accessor :document_unit
    attr_accessor :user_agent
    attr_accessor :text_encoding
    attr_accessor :ttl
    attr_accessor :force
    attr_accessor :inline
    attr_accessor :auth_user
    attr_accessor :auth_password
    attr_accessor :encryption
    attr_accessor :no_images
    attr_accessor :no_hyperlinks
    attr_accessor :accept_lang
    attr_accessor :no_backgrounds
    attr_accessor :no_javascript
    attr_accessor :use_print_media
    attr_accessor :grayscale
    attr_accessor :low_quality
    attr_accessor :forms
    attr_accessor :no_print
    attr_accessor :no_modify
    attr_accessor :no_copy
    attr_accessor :page_size
    attr_accessor :page_width
    attr_accessor :page_height
    attr_accessor :orientation
    attr_accessor :header_text
    attr_accessor :header_align
    attr_accessor :header_url
    attr_accessor :header_html
    attr_accessor :header_spacing
    attr_accessor :footer_text
    attr_accessor :footer_align
    attr_accessor :footer_url
    attr_accessor :footer_html
    attr_accessor :footer_spacing
    attr_accessor :css_url
    attr_accessor :delay
    attr_accessor :dpi
    attr_accessor :zoom
    attr_accessor :page_numbering_offset
    attr_accessor :watermark_url
    attr_accessor :watermark_opacity
    attr_accessor :watermark_offset_x
    attr_accessor :watermark_offset_y
    attr_accessor :watermark_in_background
    attr_accessor :title
    attr_accessor :subject
    attr_accessor :creator
    attr_accessor :author

    def initialize()
      @query = nil
    end

  end

end
