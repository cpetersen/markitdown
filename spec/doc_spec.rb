require 'markitdown'

describe Markitdown do  
  context "When parsing a document" do
    let(:html) { File.read("spec/doc.html") }

    it "should produce valid markdown" do
      Markitdown.from_html(html).should == "

# Main Header

This *is* a **test**. It includes a [link](http://www.google.com) as well as an image ![Google Logo](https://www.google.com/images/srpr/logo3w.png) 

 * bullet 1
 * bullet 2
 * bullet 3

***

## Subheader

This is paragraph two.

 1. bullet 1
 1. bullet 2
 1. bullet 3

"
    end
  end
end
