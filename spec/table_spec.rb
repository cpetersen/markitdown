require 'markitdown'
require 'spec_helper'

describe Markitdown do  
  context "When parsing a table with a thead and tbody" do
    let(:html) { File.read("spec/table.html") }

    it "should produce valid markdown" do
      Markitdown.from_html(html).should == File.read("spec/table.markdown")
    end
  end

  context "When parsing a table without a thead and tbody" do
    let(:html) { File.read("spec/table2.html") }

    it "should produce valid markdown" do
      Markitdown.from_html(html).should == File.read("spec/table2.markdown")
    end
  end
end
