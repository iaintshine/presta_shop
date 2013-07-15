# PrestaShop

The Presta Shop API gem allows Ruby developers to programmatically interact with Presta Shop's Web Service API.

The API is implemented as XML over HTTP using five verbs: HEAD/GET/POST/PUT/DELETE

## Installation

Add this line to your application's Gemfile:

	gem 'presta_shop'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install presta_shop

## Usage

1. Using your admin panel generate an authentication key. 
2. Assign rights for each resource that you want to make available for this key.
3. Initialize the library
	
	```ruby
	PrestaShop.configure do |c|
		c.api_url = "http://your/presta/shop"
		c.api_key = "YOURAPIKEY"
	end

	PrestaShop.bootstrap!
	```

4. Make a request

	```ruby
	PrestaShop.get(:resource => :shops, :id => 1)
	```
	
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
