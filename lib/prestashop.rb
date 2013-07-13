require "core/string_ext"
require "core/hash_ext" unless Hash.method_defined?(:except)

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
		response = execute options
		parse response, options
	end

	def self.head(options)
		options[:method] = :head
		begin
			execute options
			true
		rescue => e
			return false unless e.http_code != 404
			raise InvalidRequest
		end
	end

	def self.add(options)
		options[:method] = :post
		response = execute options
		parse response
	end

	def self.edit(options)
		# should return true or false
		options[:method] = :put
		begin
			execute options
			true
		rescue => e
			return false unless e.http_code != 404
			raise InvalidRequest
		end
	end

	def self.delete(options)
		# should return true or false
		options[:method] = :delete
		begin
			execute options
		rescue => e
			return false unless e.http_code != 404
			raise InvalidRequest
		end
	end
end
