# More OO way - wrap in class

module PrestaShop
    def self.bootstrap!
        configuration.validate!

        query_permissions
    end

    def self.query_permissions
        response = nil 

        response = RestClient::Request.new( :method => :get, 
                                            :url => configuration.api_url,
                                            :user => configuration.api_key,
                                            :headers => configuration.headers).execute 
        response.proxy = ENV['https_proxy']
        Headers.new(response).validate!

        xml_doc = Nokogiri::XML(response) do |config|
            config.noblanks
        end

        # Any additional validation?
        return if xml_doc.root.children.empty?

        # This one assumes only first shop is taken under consideration
        first_shop = xml_doc.root.children.first

        return if first_shop.children.empty?

        first_shop.children.each do |n|
            # this requires rails
            attributes = {}

            n.attributes.except("href").each do |k, v| 
                attributes[k] = v.value.to_boolean
            end

            # permissions need string as a resource
            permissions[n.name.to_s] = RestMethods.new attributes
        end
    end
end
