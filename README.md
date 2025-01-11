# Borsh for Ruby

[![License](https://img.shields.io/badge/license-Public%20Domain-blue.svg)](https://unlicense.org)
[![Compatibility](https://img.shields.io/badge/ruby-2.6%2B-blue)](https://rubygems.org/gems/borsh)
[![Package](https://img.shields.io/gem/v/borsh)](https://rubygems.org/gems/borsh)

A Ruby library for the [Borsh] binary serialization format.

[Borsh]: https://borsh.io

## 🛠️ Prerequisites

- [Ruby](https://ruby-lang.org) 2.6+

## ⬇️ Installation

### Installation via RubyGems

```bash
gem install borsh
```

## 👉 Examples

### Importing the library

```ruby
require 'borsh'
```

### Writing to an output stream

```ruby
$stdout.extend(Borsh::Writable)
$stdout.write_string("Hello, world!")
```

### Reading from an input stream

```ruby
$stdin.extend(Borsh::Readable)
p $stdin.read_string
```

### Writing to an in-memory buffer

```ruby
serialized_data = Borsh::Buffer.open do |buf|
  # Primitive types:
  buf.write_bool(true)
  buf.write_u8(255)
  buf.write_i32(-12345)
  buf.write_f64(3.14159)
  buf.write_string("Hello, Borsh!")

  # Fixed-size array:
  buf.write_array([1, 2, 3])

  # Dynamic-sized array (array with a length prefix):
  buf.write_vector(['a', 'b', 'c'])
end
```

### Reading from an in-memory buffer

```ruby
Borsh::Buffer.new(serialized_data) do |buf|
  # Primitive types:
  bool_val = buf.read_bool             # => true
  u8_val = buf.read_u8                 # => 255
  i32_val = buf.read_i32               # => -12345
  f64_val = buf.read_f64               # => 3.14159
  string_val = buf.read_string         # => "Hello, Borsh!"

  # Fixed-size array:
  array = buf.read_array(:i32, 3)      # => [1, 2, 3]

  # Dynamic-sized array (array with a length prefix):
  vector = buf.read_vector(:string)    # => ['a', 'b', 'c']
end
```

## 📚 Reference

| Informal Type | `Borsh::Writable` | `Borsh::Readable` |
| :------------ | :---------------- | :---------------- |
| nil/unit | `write_unit()` | `read_unit()` |
| boolean | `write_bool(x)` | `read_bool()` |
| u8 integer | `write_u8(n)` | `read_u8()` |
| u16 integer | `write_u16(n)` | `read_u16()` |
| u32 integer | `write_u32(n)` | `read_u32()` |
| u64 integer | `write_u64(n)` | `read_u64()` |
| u128 integer | `write_u128(n)` | `read_u128()` |
| i8 integer | `write_i8(n)` | `read_i8()` |
| i16 integer | `write_i16(n)` | `read_i16()` |
| i32 integer | `write_i32(n)` | `read_i32()` |
| i64 integer | `write_i64(n)` | `read_i64()` |
| i128 integer | `write_i128(n)` | `read_i128()` |
| f32 float | `write_f32(f)` | `read_f32()` |
| f64 float | `write_f64(f)` | `read_f64()` |
| string | `write_string(x)` | `read_string()` |
| array | `write_array(x)` | `read_array(element_type, count)` |
| vector | `write_vector(x)` | `read_vector(element_type)` |
| struct | `write_struct(x)` | `read_struct(struct_class)` |
| enum | `write_enum(x)` | `read_enum(variants)` |
| map/hash | `write_map(x)` | `read_map(key_type, value_type)` |
| set | `write_set(x)` | `read_set(element_type)` |
| option | `write_option(x)` | `read_option(element_type)` |
| result | `write_result(x)` | `read_result(ok_type, err_type)` |

## 👨‍💻 Development

```bash
git clone https://github.com/dryruby/borsh.rb.git
```

- - -

[![Share on Twitter](https://img.shields.io/badge/share%20on-twitter-03A9F4?logo=twitter)](https://twitter.com/share?url=https://github.com/dryruby/borsh.rb&text=Borsh+for+Ruby)
[![Share on Reddit](https://img.shields.io/badge/share%20on-reddit-red?logo=reddit)](https://reddit.com/submit?url=https://github.com/dryruby/borsh.rb&title=Borsh+for+Ruby)
[![Share on Hacker News](https://img.shields.io/badge/share%20on-hacker%20news-orange?logo=ycombinator)](https://news.ycombinator.com/submitlink?u=https://github.com/dryruby/borsh.rb&t=Borsh+for+Ruby)
[![Share on Facebook](https://img.shields.io/badge/share%20on-facebook-1976D2?logo=facebook)](https://www.facebook.com/sharer/sharer.php?u=https://github.com/dryruby/borsh.rb)
