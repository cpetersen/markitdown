require 'markitdown'
require 'spec_helper'

describe Markitdown do  
  context "When parsing codeblocks" do
    let(:html) { File.read("spec/code.html") }

    context "and not guessing the language" do
      let(:markdown) { File.read("spec/code_without_language.markdown") }

      it "should produce valid markdown" do
        Markitdown.from_html(html).should == markdown
      end
    end

    context "and guessing the language" do
      let(:markdown) { File.read("spec/code_with_language.markdown") }
      let(:classifier) { TestLanguageClassifier.new }

      it "should produce valid markdown" do
        Markitdown.from_html(html, classifier).should == markdown
      end
    end
  end

  context "When parsing codeblocks that contain nbsp" do
    let(:html) { File.read("spec/code_with_nbsp.html") }
    let(:markdown) { File.read("spec/code_with_nbsp.markdown") }

    it "should produce valid markdown" do
      Markitdown.from_html(html).should == markdown
    end
  end
end
