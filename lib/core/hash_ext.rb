class Hash
    def except(*keys)
        dup.except! *keys
    end

    def except!(*keys)
        keys.each do |key| 
            delete key
        end
        self
    end
end