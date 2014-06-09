model-publish-gem
=================

用来给模型实例标记发布/未发布状态
=======

## Installation

Add this line to your application's Gemfile:

    gem 'model-state'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install model-state

## Usage

针对某个模型，增加一个状态字段，并声明其状态枚举类型

```ruby
class MyModel
  include ModelState
  
  add_state :some_state, 
            :states  => [:aaa, :bbb, :ccc],
            :default => :aaa

  add_state :another_state, 
            :states  => [:s1, :s2, :s3],
            :default => :s2
end
```

针对某个模型，获取指定状态的所有实例:

```ruby
Model.on_states(:some_state => :aaa, :another_state => :s1)
```

针对指定的模型实例，将其标记为声明的状态:

```ruby
record.set_states(:some_state => :bbb, :another_state => :s3)
```

针对指定的模型实例，查询其指定的当前状态:

```ruby
record.get_states(:some_state, :another_state)
#=> {:some_state => :AAA, :another_state => :S2}
```

针对指定的模型实例，查询其是否处于指定状态:

```ruby
record.on_states?(:some_state => :aaa)
```

针对指定的模型实例，将其标记某一状态:

```ruby
record.set_state(:some_state, :bbb)
```

针对指定的模型实例，查询其当前某一状态:

```ruby
record.get_state(:some_state)
#=> :AAA
```

针对指定的模型实例，查询其是否处于某一状态:

```ruby
record.on_state?(:some_state, :aaa)
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/model-state/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
