# Cloaked

[![Build Status](https://secure.travis-ci.org/lightthefuserun/cloaked.svg?branch=master)](https://travis-ci.org/lightthefuserun/cloaked)
[![Code Climate](https://codeclimate.com/github/lightthefuserun/cloaked.svg)](https://codeclimate.com/github/lightthefuserun/cloaked)

Cloaked provides a simple mechanism to help obfuscate ActiveRecord ids and/or other database attributes by generating public keys that can be used and made publicly visible.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cloaked'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cloaked

## Usage

Cloaked needs to be included in your model:

```ruby
class Post < ApplicationRecord
  include Cloaked
end
```

After including it in the model, you can specify the list of public keys for which you want to generate public keys:

```ruby
class Post < ApplicationRecord
  include Cloaked

  with_cloaked_keys :public_id
end
```

By default, cloak will generate a random URL-safe base64 of 8 bytes. You can specify a different method for generating the public keys:

```ruby
class Post < ApplicationRecord
  include Cloaked

  with_cloaked_keys :public_id, method: :hex 
end
```

Will generate a random hexadecimal string with 16 characters.

```ruby
class Post < ApplicationRecord
  include Cloaked

  with_cloaked_keys :public_id, method: :uuid 
end
```

Will generate a v4 random UUID (Universally Unique IDentifier).

You can specify a custom length:

```ruby
class Post < ApplicationRecord
  include Cloaked

  with_cloaked_keys :public_id, size: 16
end
```

Only applies to `:base64` and `hex`. Note that in the latter case, the length of the hexadecimal string will be twice the size amount.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/colochousing/cloaked. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Cloaked project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/cloaked/blob/master/CODE_OF_CONDUCT.md).

## TODO

- Load Cloaked automatically with railtie.
