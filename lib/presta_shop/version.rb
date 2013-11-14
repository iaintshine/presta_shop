module PrestaShop
    MAJOR = 0
    MINOR = 1
    TINY  = 2

    VERSION = [MAJOR, MINOR, TINY].join('.')

    def self.version
        VERSION
    end
end
