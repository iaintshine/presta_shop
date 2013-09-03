module PrestaShop
	module Testing
		module WebMocks
			def self.initialize
				# basic auth api_key: base64 encoded
				static_responses = {}

				Dir[File.expand_path('../static_response/*.xml', __FILE__)].each do |path|
					static_responses[Pathname.new(path).basename.to_s] = File.read(path)
				end

				# Authentication 
				FakeWeb.register_uri(:get, "http://PRESTASH00PAPIKEY@newer/presta/shop/api/", :body => "Authorized", :status => ["200", "OK"], "PSWS-Version" => "2.0.0" )
				FakeWeb.register_uri(:any, "http://presta/shop/api/", :status => ["401", "Unauthorized"])
				
				# Query resource
				FakeWeb.register_uri(:get, "http://INVALIDAPIKEY@presta/shop/api/", :body => "Unauthorized", :status => ["401", "Unauthorized"])
				FakeWeb.register_uri(:get, "http://PRESTASH00PAPIKEY@presta/shop/api/", :body => static_responses["api_root.xml"], "PSWS-Version" => "1.5.0.0")
				FakeWeb.register_uri(:get, "http://PRESTASH00PAPIKEYWEAK@presta/shop/api/", :body => static_responses["api_read_only.xml"], "PSWS-Version" => "1.5.0.0")
				FakeWeb.register_uri(:get, "http://PRESTASH00PAPIKEY@presta/shop/api/shops", :body => static_responses["api_shops.xml"], "PSWS-Version" => "1.5.0.0")
				FakeWeb.register_uri(:get, "http://PRESTASH00PAPIKEY@presta/shop/api/shops/1", :body => static_responses["api_shops_1.xml"], "PSWS-Version" => "1.5.0.0")

				# Query resource existance
				FakeWeb.register_uri(:head, "http://PRESTASH00PAPIKEY@presta/shop/api/shops", :status => ["200", "OK"], "PSWS-Version" => "1.5.0.0")
				FakeWeb.register_uri(:head, "http://PRESTASH00PAPIKEY@presta/shop/api/shops/1", :status => ["200", "OK"], "PSWS-Version" => "1.5.0.0")

				# Create resource
				FakeWeb.register_uri(:post, %r|http://PRESTASH00PAPIKEY@presta/shop/api/shops|, :body => static_responses["api_shops_create_response.xml"], "PSWS-Version" => "1.5.0.0")
				
				# Update resource
				FakeWeb.register_uri(:get, %r|http://PRESTASH00PAPIKEY@presta/shop/api/shops/3|, :body => static_responses["api_shops_create_response.xml"], "PSWS-Version" => "1.5.0.0")
				FakeWeb.register_uri(:put, %r|http://PRESTASH00PAPIKEY@presta/shop/api/shops/3|, :body => static_responses["api_shops_update_response.xml"], "PSWS-Version" => "1.5.0.0")
				
				# Delete resource
				FakeWeb.register_uri(:delete, "http://PRESTASH00PAPIKEY@presta/shop/api/shops/3", :status => ["200", "OK"], "PSWS-Version" => "1.5.0.0")
				FakeWeb.register_uri(:any, %r|http://PRESTASH00PAPIKEY@presta/shop/api/shops/10|, :status => ["404", "Not Found"], "PSWS-Version" => "1.5.0.0")

			end
		end
	end
end