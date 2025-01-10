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

### Writing an output stream

```ruby
$stdout.extend(Borsh::Writable)
$stdout.write_string("Hello, world!")
```

### Reading an input stream

```ruby
$stdin.extend(Borsh::Readable)
p $stdin.read_string
```

## 👨‍💻 Development

```bash
git clone https://github.com/dryruby/borsh.rb.git
```

- - -

[![Share on Twitter](https://img.shields.io/badge/share%20on-twitter-03A9F4?logo=twitter)](https://twitter.com/share?url=https://github.com/dryruby/borsh.rb&text=Borsh+for+Ruby)
[![Share on Reddit](https://img.shields.io/badge/share%20on-reddit-red?logo=reddit)](https://reddit.com/submit?url=https://github.com/dryruby/borsh.rb&title=Borsh+for+Ruby)
[![Share on Hacker News](https://img.shields.io/badge/share%20on-hacker%20news-orange?logo=ycombinator)](https://news.ycombinator.com/submitlink?u=https://github.com/dryruby/borsh.rb&t=Borsh+for+Ruby)
[![Share on Facebook](https://img.shields.io/badge/share%20on-facebook-1976D2?logo=facebook)](https://www.facebook.com/sharer/sharer.php?u=https://github.com/dryruby/borsh.rb)
