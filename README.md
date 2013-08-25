# Markitdown [![Build Status](https://secure.travis-ci.org/cpetersen/markitdown.png)](http://travis-ci.org/cpetersen/markitdown) [![Coverage Status](https://coveralls.io/repos/cpetersen/markitdown/badge.png?branch=master)](https://coveralls.io/r/cpetersen/markitdown?branch=master) [![Gem Version](https://badge.fury.io/rb/markitdown.png)](http://badge.fury.io/rb/markitdown)

Markitdown is a Ruby library that converts HTML to Markdown. It's powered by Nokogiri. It supports:

 * Ordered and unordered lists
 * Nested lists
 * Blockquotes
 * Lists (and nested list) inside of block quotes
 * Images
 * Links
 * Code (inline and blocks)
 * Definition lists
 * Tables
 * Underlines
 * Strikethroughs (strike or del tags)
 * Highlights (mark tag)
 * Superscripts (sup tag)

As well as other tags.

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
Markitdown.from_nokogiri(nokogiri_node)
```

## Example

From the specs:

### HTML
```html
<html>
  <head>
    <title>Test Document</title>
  </head>
  <body>
    <h1>Main Header</h1>
    <p>
      This <em>is</em> a <b>test</b>. It includes a <a href="http://www.google.com">link</a> as well as an image <img src="https://www.google.com/images/srpr/logo3w.png" alt="Google Logo" />
      <ul>
        <li>bullet 1</li>
        <li>bullet 2</li>
        <li>bullet 3</li>
      </ul>
    </p>
    <hr/>
    <h2>Subheader</h2>
    <p>
      This is paragraph two.
      <ol>
        <li>bullet 1</li>
        <ul>
          <li>Sub-bullet 1 <a href="http://github.com">Nested link</a>.</li>
        </ul>
        <li>bullet 2</li>
        <li>bullet 3</li>
      </ol>
    </p>
  </body>
</html>
```

Gets converted to the following Markdown:

```md


# Main Header

This *is* a **test**. It includes a [link](http://www.google.com) as well as an image ![Google Logo](https://www.google.com/images/srpr/logo3w.png) 

 * bullet 1
 * bullet 2
 * bullet 3

***

## Subheader

This is paragraph two.

 1. bullet 1
    * Sub-bullet 1 [Nested link](http://github.com).
 1. bullet 2
 1. bullet 3


```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
