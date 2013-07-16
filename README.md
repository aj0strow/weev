# Weev

> Weave together organized JSON documents

There are a number of excellent JSON serializers, presenters, etc out there, I haven't found any that focus on multiple presentations for the same object. Weev uses a simple DSL to allow you to create very complex JSON documents with ease.

A few assumptions:

1. Every element in the representations corresponds to a real ruby method
2. Objects are *not* prefixed
3. Objects know how to serialize themselves

### Serializer

The Weev serializer takes a serialization strategy, and then can serialize as many objects with that strategy as necessary. You can cascade name strategies as well, and any `methods` or `serialize` commands outside of a strategy are added as defaults. 

```ruby
class UserSerializer
  include Weev::Serializer
  
  methods :yay, :hello, :yup, :whats_good
  
  attribute :special_key, :method_name, 'arg0', 'arg1'
  
  for :index do
    methods :description
    serialize :likes, LikeSerializer        # default group
  end
  
  for :show do
    serialize :comments, CommentSerializer, :group
  end
  
  for :stats do
    index
    methods :visitor_count, :ad_clicks
  end
end
````

And create then with the following:

```ruby
serializer = UserSerializer.new(:show)
serializer.json(@user)
```

### Configuration

```ruby
Weev.configure do |config|
  config.camel_case = true
end
```

## Installation

Add this line to your application's Gemfile:

    gem 'weev'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install weev

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
