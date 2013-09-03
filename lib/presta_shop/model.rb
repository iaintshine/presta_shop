require "hashie"

require "presta_shop/mixin/crud"
require "presta_shop/mixin/orm"

module PrestaShop
	class Model < Hashie::Mash
		include PrestaShop::Mixin::CRUD
		include PrestaShop::Mixin::ORM

		class << self
			def resource(value = nil)
				value.nil? ? @resource : @resource = value
			end
		end
	end	
end