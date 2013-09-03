module PrestaShop
    MAJOR = 0
    MINOR = 0
    TINY  = 3

    VERSION = [MAJOR, MINOR, TINY].join('.')

    def self.version
        VERSION
    end
end
