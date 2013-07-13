require 'rspec'
require 'fakeweb'

require 'presta_shop'

# Require everything in `spec/support`
Dir[File.expand_path('../../spec/support/**/*.rb', __FILE__)].map(&method(:require))

PrestaShop::Testing::WebMocks.initialize

RSpec.configure do |config|
  config.order = 'random'

  config.before :each do 
  	# TODO:
  end

  config.after :each do
  	# TODO:
  end
end
