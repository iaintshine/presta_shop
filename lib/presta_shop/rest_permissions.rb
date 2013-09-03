require "presta_shop/resources"
require "presta_shop/rest_methods"

# keys are string !
module PrestaShop
    class RestPermissions
        attr_accessor :resources

        def initialize
            @resources = Hash.new

            RESOURCES.each do |resource|
                # no access by default
                @resources[resource] = RestMethods.new
            end
        end

        def []=(resource, methods)
            raise ArgumentError, "#{resource} => invalid resource type" unless RESOURCES.include? resource
            raise ArgumentError, "only PrestaShop::RestMethods arguments are valid" unless methods.kind_of?(PrestaShop::RestMethods)
            resources[resource] = methods
        end

        def [](resource)
            resources[resource]
        end

        def respond_to?(method_name)
            resources.has_key? method_name
        end

        def method_missing(method_name, *args, &block)
            method_string = method_name.to_s
            if respond_to? method_string
                resources[method_string]
            else
                super method_name, *args, &block
            end
        end
    end
end