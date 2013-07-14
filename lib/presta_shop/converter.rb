module PrestaShop
	module Converter
		def self.convert(resource_type, resource_hash)
			resource = resource_type.to_s
			raise UnknownResource unless RESOURCES.include? resource
			
			# TODO: user singularize from rails 
			singular_resource = resource[0..-2]

			builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
				xml.prestahop("xmlns:xlink" =>"http://www.w3.org/1999/xlink") {
					xml.send(singular_resource) {
						resource_hash.each do |key, value|
							xml.send(key) {
								xml.cdata value
							}
						end
					}
				}
			end

			builder.to_xml
		end
	end
end