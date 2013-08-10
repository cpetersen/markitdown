require 'markitdown'
require 'spec_helper'

describe Markitdown do
  context "when parsing nested ordered lists" do
    let(:html) { "
      <ol>
        <li>line 1.1</li>
        <ol>
          <li>line 2.1</li>
          <li>line 2.2</li>
          <ol>
            <li>line 3.1</li>
            <li>line 3.2</li>
          </ol>
        </ol>
        <li>line 1.2</li>
      </ol>"
    }
    it "should return valid markdown" do
      Markitdown.from_html(html).should == "

 1. line 1.1
    1. line 2.1
    1. line 2.2
       1. line 3.1
       1. line 3.2
 1. line 1.2
"
    end
  end

  context "when parsing nested unordered lists" do
    let(:html) { "
      <ul>
        <li>line 1.1</li>
        <ul>
          <li>line 2.1</li>
          <li>line 2.2</li>
          <ul>
            <li>line 3.1</li>
            <li>line 3.2</li>
          </ul>
        </ul>
        <li>line 1.2</li>
      </ul>"
    }
    it "should return valid markdown" do
      Markitdown.from_html(html).should == "

 * line 1.1
   * line 2.1
   * line 2.2
     * line 3.1
     * line 3.2
 * line 1.2
"
    end
  end

  context "when parsing nested ordered and unordered lists" do
    let(:html) { "
      <ul>
        <li>line 1.1</li>
        <ol>
          <li>line 2.1</li>
          <li>line 2.2</li>
          <ul>
            <li>line 3.1</li>
            <li>line 3.2</li>
          </ul>
        </ol>
        <li>line 1.2</li>
      </ul>"
    }
    it "should return valid markdown" do
      Markitdown.from_html(html).should == "

 * line 1.1
   1. line 2.1
   1. line 2.2
      * line 3.1
      * line 3.2
 * line 1.2
"
    end
  end

  context "when parsing an unordered list nested under a blockquote" do
    let(:html) { "
      <blockquote>
        This is a quote with a list
        <ul>
          <li>item 1</li>
          <li>item 2</li>
        </ul>
      </blockquote>" }
    it "should return valid markdown" do
      Markitdown.from_html(html).should == 
"

 > This is a quote with a list
 >  * item 1
 >  * item 2

"
    end
  end


  context "when parsing nested lists with links nested under a blockquote" do
    let(:html) { "
      <blockquote>
        This is a quote with a list
        <ul>
          <li>item <a href='http://www.google.com'>1.1</a></li>
          <ol>
            <li>item <a href='http://www.google.com'>2.1</a></li>
            <li>item 2.2</li>
          </ol>
          <li>item 1.2</li>
        </ul>
      </blockquote>" }
    it "should return valid markdown" do
      Markitdown.from_html(html).should == 
"

 > This is a quote with a list
 >  * item [1.1](http://www.google.com) 
 >    1. item [2.1](http://www.google.com) 
 >    1. item 2.2
 >  * item 1.2

"
    end
  end
end
