module PrestaShop
    class QueryParams
        attr_accessor :options

        def initialize(options = nil)
            @options = options
        end

        def validate!
            return true if options.nil? or options.empty?

              supported = Set.new ['xml', 'filter', 'display', 'sort', 'limit', 'schema', 'date', 'id_shop']
              found = Set.new
            options.each_key do |key|
                # filter[id] -> ["filter", "id]"] -> "filter"
                # or :filter -> "filter" -> ["filter"] -> "filter"
                found << key.to_s.split('[')[0]
            end

            difference = found - supported
            raise UnsupportedParamsError unless difference.empty?

            true 
        end

        def to_s
            return "" if options.nil? or options.empty?

            options.collect do |key, value|
                "#{key}=#{CGI.escape(value.to_s)}"
            end.join '&'
        end
    end
end