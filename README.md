# Weev

> Weave together organized JSON documents with varied strategies

Weev is used to turn complex ruby objects, like those used in Ruby ORMs (ActiveRecord, Sequel, DataMapper) into simple ones made up of Hashes, Arrays, Strings, and the like. This task has traditionally been done with an `as_json` method. Weev is better at declaring multiple representations of the same object, and nesting them within relationships. 

To actually generate raw JSON from the serialized object, check out [MultiJson](https://github.com/intridea/multi_json). 

##### A few assumptions:

1. Every key in the JSON representations corresponds to a real ruby method
2. Objects are *not* prefixed
3. Typically 1:1 for seralizer to resource/model

To serialize an object, first create and cache a serializer:

```ruby
def user_serializer
  @user_serializer ||= UserSerializer.new(:profile)
end
```

And then dump the output to JSON:

```ruby
@user = User.find(params[:id])
MultiJson.dump(user_serializer.serialize(@user))
```

### A Use Case

> Skip this if you're convinced Weev is useful already.

Suppose you have a blog, with Users, Articles and Comments. They might look like the following:

```javascript
// User
{
  name: "User Name",
  email: "user-email@github.com",
  recentArticles: [ 
    // article objects
  ] 
}

// Article
{
  title: "Interesting Article",
  author: {
    // user object
  },
  comments: [
    // comment objects
  ]
}

// Comment
{
  content: "I really like your article!",
  commentator: {
    // user object
  }
}
```

You can't just render the associations to JSON, because they would recurse forever. And it sucks to pass in the methods you want to call by hand each time. You need serializers!

### Serializer

The whole point of Weev is *named serialization strategies*. For example, you might have a `:commentator` strategy and a `:profile` strategy for Users in the above use case. 

Here's a simple example of defining serializers:

```ruby
class ChildSerializer
  include Weev::Serializer
  
  strategy :default do
    attributes :name, :age
  end
end

class ParentSerializer
  include Weev::Serializer
  
  strategy :info do
    attributes :name, :email
  end
  
  strategy :profile do
    strategy :info
    attribute :custom_method, 'argument 0', 'argument 1'
    relation :children, ChildSerializer.new(:default)
  end
end
````

For a full example with Structs, Serializers and the output of serialization see `demo/user_profiles.rb`. You can also pass in parameters to relation:

```ruby
relation :invoices, { paid: true }, InvoiceSerializer.new(:list_item)
# object.invoices({ paid: true })
```

### Configuration

The default is to turn underscored method names into camelCase keys in the JSON. To not do that, set the option to false:

```ruby
Weev.configure do |config|
  config.camel_case = false
end
```

The suggested location for serializers is in their own folder:

```
+ app
  - models
  - serializers
```

## Installation

If people start using it besides me, I'll put it on Rubygems. For now, just install from the git:

```ruby
gem 'weev', github: 'aj0strow/weev'
```

## Notes

Would love opinions, issue reports and suggestions. Weev is supposed to be the *easiest* way to generate complex and/or nested JSON documents, and came from a very real need for such a gem.  

Suggested way to contribue:

1. Fork aj0strow/weev
2. Create a feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added this feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a Pull Request with a little info for me
