module PrestaShop
    class Mixin
        module ORM
            def new?
                id.nil?
            end

            def persisted?
                !new?
            end

            def destroyed?
                @destroyed == true
            end

            def save!
                if new?
                    created_resource = PrestaShop.create :resource => self.class.resource,
                                                           :payload  => self

                    shallow_update created_resource
                else
                    PrestaShop.update :resource => self.class.resource, 
                                      :id         => self.id,
                                      :payload     => self
                end

                self
            end

            def destroy
                return false unless persisted?

                @destroyed = PrestaShop.delete :resource => self.class.resource,
                                               :id         => self.id

                @destroyed
            end
        end
    end
end