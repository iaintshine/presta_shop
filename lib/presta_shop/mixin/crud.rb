module PrestaShop
	class Mixin
		module CRUD
			def self.included(base)
				base.send :extend, ClassMethods
			end
		end

		module ClassMethods
			def exists?(id)
				PrestaShop.head :resource => self.resource,
								:id 	  => id
			end

			# TODO: make this call using maybe monad ... so damn verbose ...

			def find(id)
				resource_hash = PrestaShop.get 	:resource => self.resource,
							   					:id 	  => id

				resource_hash.nil? ? nil : self.new(resource_hash)
			end

			def all
				resources_array = PrestaShop.get :resource => self.resource

				if resources_array
					resources_array = resources_array.map do |resource_hash|
						self.new resource_hash
					end
				end
				resources_array
			end

			def create(resource_hash)
				created_hash = PrestaShop.create :resource => self.resource,
												  :payload  => resource_hash
												  
				created_hash.nil? ? nil : self.new(created_hash)
			end

			def update(resource_hash)
				PrestaShop.update :resource => self.resource,
								  :id       => resource_hash[:id],
								  :payload  => resource_hash
			end

			def destroy(id)
				PrestaShop.delete :resource => self.resource,
								  :id       => id
			end
		end
	end
end