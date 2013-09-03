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

4. Make a request and use a reponse

    ```ruby
    shop = PrestaShop.get(:resource => :shops, :id => 1)
    puts shop[:name]
    ```

    You can use a new high-level ActiveRecord-like ORM style as well 

    ```
    shop = PrestaShop::Shop.find(1)
    puts shop.name
    ```  
### ActiveRecord-like methods

    These are the basic ActiveRecord-like methods you can use with your models:

    ```ruby
    # Check if resource exists using an id
    PrestaShop::Shop.exists? id

    # Fetch a resource using an id
    PrestaShop::Shop.find id
    
    # Fetch a collection of resources
    PrestaShop::Shop.all
    
    # Create a new resource
    PrestaShop::Shop.create name: "new shop", id_category: 2 ...

    # Save a new resource
    shop = PrestaShop::Shop.new name: "new shop", ...
    shop.save!

    shop.persisted?

    # Update an existing resource
    shop = PrestaShop::Shop.find id
    shop.name = "changed name"
    shop.save!

    # Destroy a resource without fetching it using an id
    PrestaShop::Shop.destroy id

    # Destroy a fetched resource
    shop = PrestaShop::Shop.find id
    shop.destroy!

    shop.destroyed?
    ```
### Low-level api access
    
    ```ruby
    # Check if resource exists using an id
    PrestaShop.head resource: :shops, id: id

    # Fetch a resource using an id
    PrestaShop.get resource: :shops, id: id
    
    # Fetch a collection of resources
    PrestaShop::Shop resource: :shops
    
    # Create a new resource
    shop = { name: "new shop", id_category: 2 ... }
    PrestaShop.create resource: :shops, 
                      payload: shop 

    # Update an existing resource
    PrestaShop.update resource: :shops, id: shop[:id], payload: :shop

    # Destroy a resource using an id
    PrestaShop.delete resource: :shops, id: id
    ```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
