# Rack::Attack::Cassandra

An adapter that lets you use Rack::Attack with Cassandra.

It operates by inserting `N` row with the specified TTL for every `increment` operation, and thus the value of the key is stored as the count. Counter columns were not used because they do not support TTLs.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rack-attack-cassandra'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rack-attack-cassandra

## Usage

```
class Rack::Attack

  ### Configure Cache ###
  c = ::Cassandra.cluster
  s = c.connect("your_keyspace")
  Rack::Attack.cache.store = Rack::Attack::Cassandra.new(session: s)

  # ......
end
```

## License

MIT.
