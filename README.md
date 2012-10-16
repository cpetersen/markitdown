# Markitdown

Markitdown is a Ruby library that converts HTML to Markdown. It's powered by Nokogiri.

## Installation

Add this line to your application's Gemfile:

    gem 'markitdown'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install markitdown

## Usage

To convert HTML to Markdown:

```ruby
Markitdown.from_html(html)
```

```Markitdown``` uses Nokogiri internally. If you already have a Nokogiri object you can use ```from_nokogiri```

```ruby
Markitdown.from_html(nokogiri_node)
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
