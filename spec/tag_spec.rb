require 'markitdown'
require 'spec_helper'

describe Markitdown do
  context "When parsing a paragraph" do
    let(:html) { "<p>This is a paragraph</p>" }

    it "should return valid markdown" do
      Markitdown.from_html(html).should == "\n\nThis is a paragraph\n\n"
    end
  end

  context "When parsing an H1" do
    let(:html) { "<h1>This is a test</h1>" }

    it "should return valid markdown" do
      Markitdown.from_html(html).should == "\n\n# This is a test\n\n"
    end
  end

  context "When parsing an H2" do
    let(:html) { "<h2>This is a test</h2>" }

    it "should return valid markdown" do
      Markitdown.from_html(html).should == "\n\n## This is a test\n\n"
    end
  end

  context "When parsing an H3" do
    let(:html) { "<h3>This is a test</h3>" }

    it "should return valid markdown" do
      Markitdown.from_html(html).should == "\n\n### This is a test\n\n"
    end
  end

  context "When parsing an H4" do
    let(:html) { "<h4>This is a test</h4>" }

    it "should return valid markdown" do
      Markitdown.from_html(html).should == "\n\n#### This is a test\n\n"
    end
  end

  context "When parsing an H5" do
    let(:html) { "<h5>This is a test</h5>" }

    it "should return valid markdown" do
      Markitdown.from_html(html).should == "\n\n##### This is a test\n\n"
    end
  end

  context "When parsing an H6" do
    let(:html) { "<h6>This is a test</h6>" }

    it "should return valid markdown" do
      Markitdown.from_html(html).should == "\n\n###### This is a test\n\n"
    end
  end

  context "When parsing an HR" do
    let(:html) { "<hr/>" }

    it "should return valid markdown" do
      Markitdown.from_html(html).should == "\n\n***\n\n"
    end
  end

  context "When parsing an BR" do
    let(:html) { "<br/>" }

    it "should return valid markdown" do
      Markitdown.from_html(html).should == "\n\n"
    end
  end

  context "When parsing an EM element" do
    let(:html) { "<em>emphasis added</em>" }

    it "should return valid markdown" do
      Markitdown.from_html(html).should == " *emphasis added* "
    end
  end

  context "When parsing an italicized element" do
    let(:html) { "<i>italics added</i>" }

    it "should return valid markdown" do
      Markitdown.from_html(html).should == " *italics added* "
    end
  end

  context "When parsing a strong element" do
    let(:html) { "<strong>strong added</strong>" }

    it "should return valid markdown" do
      Markitdown.from_html(html).should == " __strong added__ "
    end
  end

  context "When parsing a bold element" do
    let(:html) { "<b>bold added</b>" }

    it "should return valid markdown" do
      Markitdown.from_html(html).should == " __bold added__ "
    end
  end

  context "When parsing a bold element that's followed by a punctuation" do
    let(:html) { "<html><b>bold added</b>.</html>" }

    it "should return valid markdown without a space" do
      Markitdown.from_html(html).should == " __bold added__."
    end
  end

  context "When parsing a em element that's followed by a punctuation" do
    let(:html) { "<html><em>emphasis added</em>?</html>" }

    it "should return valid markdown without a space" do
      Markitdown.from_html(html).should == " *emphasis added*?"
    end
  end

  context "When parsing an underlined element that's followed by a punctuation" do
    let(:html) { "<html><u>underline added</u>.</html>" }

    it "should return valid markdown without a space" do
      Markitdown.from_html(html).should == " _underline added_."
    end
  end

  context "When parsing an strikethrough element that's followed by a punctuation" do
    let(:html) { "<html><strike>strikethrough added</strike>.</html>" }

    it "should return valid markdown without a space" do
      Markitdown.from_html(html).should == " ~~strikethrough added~~."
    end
  end

  context "When parsing an delete element that's followed by a punctuation" do
    let(:html) { "<html><del>delete added</del>.</html>" }

    it "should return valid markdown without a space" do
      Markitdown.from_html(html).should == " ~~delete added~~."
    end
  end

  context "When parsing an highlight element that's followed by a punctuation" do
    let(:html) { "<html><mark>highlight added</mark>.</html>" }

    it "should return valid markdown without a space" do
      Markitdown.from_html(html).should == " ==highlight added==."
    end
  end

  context "When parsing a superscript element with no spaces" do
    let(:html) { "<html>2<sup>nd</sup>.</html>" }

    it "should return valid markdown without spaces" do
      Markitdown.from_html(html).should == "2^(nd)."
    end
  end

  context "When parsing a superscript element with spaces" do
    let(:html) { "<html>This <sup>is a</sup> test</html>" }

    it "should return valid markdown with spaces" do
      pending "Still need to figure out leading spaces for <sup> elements"
      # Markitdown.from_html(html).should == "This ^(is a) test"
    end
  end

  context "When parsing an OL" do
    let(:html) { "<ol>
  <li>first bullet</li>
  <li>second bullet</li>
  <li>third bullet</li>
</ol>"
    }
    it "should return valid markdown" do
      Markitdown.from_html(html).should == "

 1. first bullet
 1. second bullet
 1. third bullet
"
    end
  end

  context "When parsing an UL" do
    let(:html) { "<ul>
  <li>first bullet</li>
  <li>second bullet</li>
  <li>third bullet</li>
</ul>"
    }
    it "should return valid markdown" do
      Markitdown.from_html(html).should == "

 * first bullet
 * second bullet
 * third bullet
"
    end
  end

  context "When parsing a DL" do
    let(:html) { "<dl>
  <dt>first term</dt>
  <dd>first definition</dd>
  <dt>second term</dt>
  <dd>second definition</dd>
  <dt>third term</dt>
  <dd>third definition</dd>
</ol>"
    }
    it "should return valid markdown" do
      Markitdown.from_html(html).should == "

first term
 : first definition
second term
 : second definition
third term
 : third definition

"
    end
  end

  context "When parsing a link" do
    let(:html) { "<a href='http://www.google.com'>this is a link</a>" }

    it "should return valid markdown" do
      Markitdown.from_html(html).should == " [this is a link](http://www.google.com) "
    end
  end

  context "When parsing a link without an href" do
    let(:html) { "<a>this is a link</a>" }

    it "should return valid markdown" do
      Markitdown.from_html(html).should == " [this is a link]() "
    end
  end

  context "When parsing an image" do
    let(:html) { "<img src='https://www.google.com/images/srpr/logo3w.png' alt='Google Logo'>" }

    it "should return valid markdown" do
      Markitdown.from_html(html).should == " ![Google Logo](https://www.google.com/images/srpr/logo3w.png) "
    end
  end

  context "When parsing an image without an alt tag" do
    let(:html) { "<img src='https://www.google.com/images/srpr/logo3w.png'>" }

    it "should return valid markdown" do
      Markitdown.from_html(html).should == " ![](https://www.google.com/images/srpr/logo3w.png) "
    end
  end

  context "When parsing a style block" do
    let(:html) { "<style>div.whatever { font-weight: bold; }</style>" }

    it "should ignore it" do
      Markitdown.from_html(html).should == ""
    end
  end

  context "When parsing a blockquote" do
    let(:html) { "<blockquote>this is a block quote</blockquote>" }
    
    it "should return valid markdown" do
      Markitdown.from_html(html).should == "\n\n > this is a block quote\n\n"
    end
  end

  context "When parsing a multi line blockquote" do
    let(:html) { "<blockquote>
      line 1
      line 2
      line 3
    </blockquote>" }
    
    it "should return valid markdown" do
      Markitdown.from_html(html).should == "\n\n > line 1 line 2 line 3\n\n"
    end
  end

  context "When parsing an CODE element" do
    let(:html) { "<code>code block</code>" }

    it "should return valid markdown" do
      Markitdown.from_html(html).should == " `code block` "
    end
  end

end
