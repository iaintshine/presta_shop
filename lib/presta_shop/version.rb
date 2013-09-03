module PrestaShop
    MAJOR = 0
    MINOR = 1
    TINY  = 0

    VERSION = [MAJOR, MINOR, TINY].join('.')

    def self.version
        VERSION
    end
end
