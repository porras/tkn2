# Tkn2

Tkn2 is a presentation tool for the terminal. It's heavily inspired in [Xavier Noria](http://www.hashref.com/)'s
[tkn](https://github.com/fxn/tkn) (Terminal Keynote).

See [usage](#usage).

Tkn2 is work in progress. First goal is compatibility with tkn (it's almost there) and, from there, keep building
interesting features. Although the initial idea is to clone it, it might drop complete compatibility in some future
point.

Main differences with tkn:

* The commands are not available in the general namespace; you need to wrap the presentation in a `Tkn2.deck` block
* It's packed as a gem, and intended to use with bundler via a `Gemfile`. That may sound like overkill but, with tkn2
  evolving, it's nice to have each presentation stored with a explicit reference to the verion of tkn2 it was written
  for (tkn solves this having the script vendored)
* It uses [ncurses](http://www.gnu.org/software/ncurses/) instead of direct printing. This gets it some nice behaviour
  like autoredrawing when resizing windows or changing font size
* It aims to have the code better split and organized, in order to allow better extensibility and an easier time when
  adding features in the future. This is, however, a claim to be proofed.

## Usage

Have a `.rb` file requiring `tkn2` with a `Tkn2.deck` block. In that block you can use all the available commands.
You'll run that file to start the presentation

```ruby
require 'tkn2'

Tkn2.deck do
  # here goes your presentation
end
```

The easiest way to do this is to have a `Gemfile` like this:

```ruby
source 'https://rubygems.org'

gem 'tkn2'
```

And then run the presentation using bundler:

```
$ bundle exec ruby mypresentation.rb
```

### Available commands

Each command generates a slide. These are the commands available:

#### `center`

Generates a slide with the given text, centered line by line.

```ruby
center <<-EOS
  Tkn2 Less is more
EOS
```

#### `block`

Generates a slide with the given text, centered as a whole (useful for bulleted lists).

```ruby
block <<-EOS
  This is why Tkn2 is cool:
    * Reason number 1
    * Reason number 2
EOS
```

#### `code`

Highlights the code given (using [pygments.rb](https://github.com/tmm1/pygments.rb) and
[pygments](http://pygments.org/)) and displays it centered.

```ruby
code <<-RUBY
  puts 'hello'
RUBY
```

#### `section`

Generates a slide with the section title centered and proceeds with the contained slides.

```ruby
section 'This is a section' do
  center 'Slide n. 1'
  center 'Slide n. 2'
end
```

See the [`examples/`](examples/) directory.

Apart from that, it's Ruby! So you're not limited to use string literals to generate the content and you can do whatever
you want (read from the network, make calculations, etc.).

### Keys

These are the keys you can use to navigate the presentation:

* Down, Right, Enter, Space, Page Down, N: next slide
* Up, Left, Backspace, Page Up, P: previous slide
* Home: first slide
* Q: quit

## TODO / Roadmap

I'm writing Tkn2 as a way to experiment. This may make the roadmap a bit strange, as I'll be trying to bring to the
terminal the most features common in graphical presentation software, even when it will be difficult and not very practical in many cases.

That said:

* (Auto)reload [1]
* Images [1]
* Better control of *overflow* (currently the presentation crashes if the content doesn't fit in the screen). I'm
  playing with the idea of having *scroll*, something usually not present in graphical presentation software and that
  can be useful to present code without using a tiny font size
* A generator
* Colors and themes
* Plugin system. More as an exercise, I want to try to keep the core small and simple and implement features as plugins
* A way to compose slides with more than one element. Tools to generate content (ASCII art diagrams, etc.)
* Speaker's notes (with next slide, etc.). The only practical way of doing this I see is implementing a *server* and
  having two different *clients*. This *client-server* mode is an interesting feature in itself, for remote
  presentations through the network

[1] Already present in tkn.

## Thanks

* [Xavi](http://www.hashref.com/), for the great inspiration and brilliant hack

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Released under the MIT License, Copyright (c) 2013 Sergio Gil.
