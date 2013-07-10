module PrestaShop
	module Headers
		MIN_COMPATIBLE_VERSION = "1.5.0.0"
  		MAX_COMPATIBLE_VERSION = "1.5.4.1"

  		def self.valid_version?(version)
  			Gem::Version(version).between?(Gem::Version(MIN_COMPATIBLE_VERSION),
  										   Gem::Version(MAX_COMPATIBLE_VERSION))
  		end

		def self.validate!(response)
			raise UnsupportedVersion unless valid_version? response.headers["PSWS-Version"]
		end
	end
end