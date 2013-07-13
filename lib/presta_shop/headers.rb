require "rubygems/version"

module PrestaShop
	class Headers
		MIN_COMPATIBLE_VERSION = Gem::Version.new("1.5.0.0")
  		MAX_COMPATIBLE_VERSION = Gem::Version.new("1.5.4.1")

  		attr_reader :version

  		def initialize(response)
  			@version = Gem::Version.new(response.headers[:psws_version]) if response and response.headers and response.headers[:psws_version]
  		end

  		def valid_version?
  			return false unless @version
  			version.between?(MIN_COMPATIBLE_VERSION,
  							MAX_COMPATIBLE_VERSION)
  		end

		def validate!
			raise ArgumentError unless version
			raise UnsupportedVersion unless valid_version?
		end
	end
end