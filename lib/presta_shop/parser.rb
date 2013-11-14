module PrestaShop
    module Parser
        # devil and evil ! change me ! i need oop !

        module Helpers
            def self.is_associations?(n)
                n.name == 'associations'
            end

            def self.is_date?(n)
                return false
                n.name.include? 'date' or n.name == 'birthday'
            end

            PRESTA_DATETIME_FORMAT = '%Y-%m-%d %H:%M:%S'

            def self.to_datetime(string)
                begin
                    DateTime.strptime string, PRESTA_DATETIME_FORMAT
                rescue
                    DateTime.new
                end
            end

            def self.empty_tag?(n)
                n.children.size == 0
            end

            def self.prepare_data(data)
                (data.class == String && data.to_i.to_s == data) ? data.to_i : data
            end

            def self.has_value?(n)
                n.children.size == 1 and n.children.first.cdata?
            end

            def self.non_empty_value(n)
                prepare_data n.children.first.content
            end

            def self.value(n)
                if has_value? n
                    non_empty_value n
                else
                    nil
                end
            end
        end

        def self.parse(response_xml, options)
            doc = ::Nokogiri::XML response_xml do |config|
                config.noblanks
            end

            resource = doc.root.children.first

            if options[:id].nil? 
                resource_array_to_hash resource, options[:display].nil?
            else
                resource_to_hash resource
            end
        end

        def self.resource_array_to_hash(n, shallow)
            return [] if n.children.empty?

            resources = []

            unless shallow
                n.children.each do |m|
                    hash = resource_to_hash m
                    resources << hash
                end
            else
                n.children.each do |m|
                    hash = {}
                    m.attributes.each do |name, attr|
                        hash[name.to_sym] = Helpers.prepare_data attr.value
                    end
                    resources << hash
                end
            end

            resources
        end

        def self.resource_to_hash(n)
            if n.element? and !n.children.empty?
                hash = {}

                n.children.each do |m|
                    if Helpers.is_associations? m
                        get_associations hash, m
                    elsif Helpers.is_date? m
                        hash[m.name.to_sym] = Helpers.to_datetime Helpers.value m
                    else
                        hash[m.name.to_sym] = Helpers.value m
                    end
                end

                hash
            end
        end

        def self.get_associations(hash, associations)
            associations.children.each do |association|
                association_symbol = association.name.to_sym
                hash[association_symbol] = []
                association.children.each do |n|
                    item =  Hash.xml_node_to_hash n
                    hash[association_symbol] << item
                end
            end
        end

    end
end