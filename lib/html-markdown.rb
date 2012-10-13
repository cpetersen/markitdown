require "html-markdown/version"
require "nokogiri"

module Html
  module Markdown
    def self.html_to_markdown(html)
      node_to_markdown(Nokogiri::XML(html).root)
    end

    def self.node_to_markdown(node)
      self.parse_node(node).flatten.compact.join.gsub(/\n{2,}/,"\n\n").gsub(/ ([\.\?])/,'\1')
    end

    private
    def self.parse_node(node, state=[])
      results=[]
      after = nil
      state.unshift node.name.downcase
      case node.name
      when "head"
        return []
      when "title"
        return []
      when "style"
        return []
      when "div"
        after = " "
      when "span"
        after = " "
      when "p"
        results << "\n\n"
        after = "\n\n"
      when "h1"
        results << "\n\n# "
        after = "\n\n"
      when "h2"
        results << "\n\n## "
        after = "\n\n"
      when "h3"
        results << "\n\n### "
        after = "\n\n"
      when "h4"
        results << "\n\n#### "
        after = "\n\n"
      when "h5"
        results << "\n\n##### "
        after = "\n\n"
      when "h6"
        results << "\n\n###### "
        after = "\n\n"
      when "hr"
        results << "\n\n***\n\n"
      when "br"
        results << "\n\n"
      when "em"
        results << " *"
        after = "* "
      when "i"
        results << " *"
        after = "* "
      when "strong"
        results << " **"
        after = "** "
      when "b"
        results << " **"
        after = "** "
      when "ol"
        results << "\n\n"
      when "ul"
        results << "\n\n"
      when "li"
        if self.ordered_list?(state)
          results << " 1. "
        else
          results << " * "
        end
        after = "\n"
      when "a"
        results << " ["
        after = ["](#{node.attributes["href"].value}) "]
      when "img"
        results << " !["
        results << node.attributes["alt"].value if node.attributes["alt"]
        results << "]("
        results << node.attributes["src"].value if node.attributes["src"]
        results << ") "
      when "text"
        results << node.text.strip
      end
      node.children.each do |child|
        results << self.parse_node(child, state)
      end
      results << after
      state.shift
      results
    end

    def self.ordered_list?(state)
      state[1] == "ol"
    end
  end
end
