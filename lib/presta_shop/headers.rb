require "rubygems/version"

# TODO: Change it to class more oo way
module PrestaShop
	module Headers
		MIN_COMPATIBLE_VERSION = "1.5.0.0"
  		MAX_COMPATIBLE_VERSION = "1.5.4.1"

  		def self.valid_version?(version)
  			Gem::Version.new(version).between?(Gem::Version.new(MIN_COMPATIBLE_VERSION),
  										   Gem::Version.new(MAX_COMPATIBLE_VERSION))
  		end

		def self.validate!(response)
			raise ArgumentError unless response.headers["PSWS-Version"]
			raise UnsupportedVersion unless valid_version? response.headers["PSWS-Version"]
		end
	end
end