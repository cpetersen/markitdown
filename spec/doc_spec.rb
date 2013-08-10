require 'markitdown'
require 'spec_helper'

describe Markitdown do  
  context "When parsing a document" do
    let(:html) { File.read("spec/doc.html") }

    it "should produce valid markdown" do
      Markitdown.from_html(html).should == File.read("spec/doc.markdown")
    end
  end

  context "When parsing the document 'asmartbear'" do
    let(:html) { File.read("spec/asmartbear.html") }

    it "should produce valid markdown" do
      Markitdown.from_html(html).should == File.read("spec/asmartbear.markdown")
    end
  end

  context "When parsing an evernote document" do
    let(:xml) { File.read("spec/evernote.xml") }

    it "should produce valid markdown" do
      Markitdown.from_html(xml).should == File.read("spec/evernote.markdown")
    end
  end
end
