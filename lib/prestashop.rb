require "core/string_ext"
require "core/hash_ext"

require "rest_client"
require "nokogiri"

require "presta_shop/version"
require "presta_shop/errors"
require "presta_shop/resources"
require "presta_shop/rest_methods"
require "presta_shop/rest_permissions"
require "presta_shop/configuration"
require "presta_shop/headers"
require "presta_shop/query_params"
require "presta_shop/url_resolver"
require "presta_shop/parser"
require "presta_shop/converter"
require "presta_shop/executor"
require "presta_shop/bootstraper"

module PrestaShop
    def self.configure
        yield configuration

        #bootstrap!
    end

    def self.configuration
        @configuration ||= Configuration.new
    end

    def self.permissions
        @rest_permissions ||= RestPermissions.new
    end

    def self.get(options)
        options[:method] = :get
        begin 
            response = execute options
            return Parser.parse response, options
        rescue => e
            return nil if e.kind_of?(RestClient::Exception) and e.http_code == 404
            raise e
        end
    end

    def self.head(options)
        options[:method] = :head
        begin
            execute options
            true
        rescue => e
            return false if e.kind_of?(RestClient::Exception) and e.http_code == 404
            raise e
        end
    end

    def self.create(options)
        options[:method] = :post
        options[:payload] = Converter.convert(options[:resource], options[:payload]) if options[:payload]
        response = execute options
        Parser.parse response, :id => true
    end

    def self.update(options)
        options[:method] = :put
        begin
            options[:payload] = Converter.convert(options[:resource], options[:payload]) if options[:payload]
            execute options
            true
        rescue => e
            return false if e.kind_of?(RestClient::Exception) and e.http_code == 404
            raise e
        end
    end

    def self.delete(options)
        options[:method] = :delete
        begin
            execute options
            true
        rescue => e
            return false if e.kind_of?(RestClient::Exception) and e.http_code == 404
            raise e
        end
    end
end

require "presta_shop/model"
require "presta_shop/models"
