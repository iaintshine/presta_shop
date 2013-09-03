module PrestaShop
    class RestMethods
        attr_accessor :head, :get, :post, :put, :delete

        alias_method :head?,   :head
        alias_method :get?,    :get
        alias_method :post?,   :post
        alias_method :put?,    :put
        alias_method :delete?, :delete

        def initialize(attributes = nil)
            @head = false
            @get  = false
            @post = false
            @put  = false
            @delete = false
            
            unless attributes.nil? or attributes.empty?
                attributes.each do |name, attr|
                    self.send "#{name}=", attr
                end
            end
        end

        def supported?(method)
            self.send method
        end

        def read_only?
            (head? or get?) and !(post? or put? or delete?)
        end

        def write_only?
            !(head? or get?) and (post? or put? or delete?)
        end

        def read_write?
            (head? or get?) and (post? or put? or delete?)
        end

        def any?
            head? or get? or post? or put? or delete?
        end
    end
end