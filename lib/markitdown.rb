require "markitdown/version"
require "nokogiri"

module Markitdown
  def self.from_html(html)
    from_nokogiri(Nokogiri::XML(html).root)
  end

  def self.from_nokogiri(node)
    # gsub(/\n\s+\n/,"\n\n") - remove lines with nothing but space characters
    # gsub(/\n{2,}/,"\n\n") - collapse any series of more an than 2 new lines down to 2
    # gsub(/\t+/," ") - collapse consecutive tabs down to a single space. I use tabs to pad divs and span, this causes multiple nested spans and divs to ultimately be surrounded by a single space.
    # gsub(/ ([\.\?])/,'\1') - removes a space before a period or question mark. Things like links get surrounded by spaces. If they appear at the end of a sentence, this makes sure the punctation isn't off.
    self.parse_node(node).flatten.compact.join.gsub(/\n\s+\n/,"\n\n").gsub(/\n{2,}/,"\n\n").gsub(/( > \n){2,}/,"\n > \n > ").gsub(/\t+/," ").gsub(/ ([\.\?])/,'\1')
  end

  private
  def self.parse_node(node, states=[])
    results=[]
    after = nil
    states.unshift node.name.downcase
    pre = prefix(states)
    strip_contents = false
    case node.name
    when "head"
      return []
    when "title"
      return []
    when "style"
      return []
    when "div"
      results << "\t"
      after = "\t"
    when "span"
      results << "\t"
      after = "\t"
    when "p"
      results << self.newline(pre, nil, 2)
      after = self.newline(pre, nil,  2)
    when "h1"
      results << self.newline(pre, nil,  2)
      results << "# "
      after = self.newline(pre, nil,  2)
    when "h2"
      results << self.newline(pre, nil,  2)
      results << "## "
      after = self.newline(pre, nil,  2)
    when "h3"
      results << self.newline(pre, nil,  2)
      results << "### "
      after = self.newline(pre, nil,  2)
    when "h4"
      results << self.newline(pre, nil,  2)
      results << "#### "
      after = self.newline(pre, nil,  2)
    when "h5"
      results << self.newline(pre, nil,  2)
      results << "##### "
      after = self.newline(pre, nil,  2)
    when "h6"
      results << self.newline(pre, nil,  2)
      results << "###### "
      after = self.newline(pre, nil,  2)
    when "hr"
      results << self.newline(pre, nil,  2)
      results << "***"
      results << self.newline(pre, nil,  2)
    when "br"
      results << self.newline(pre, nil,  2)
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
    when "blockquote"
      results << "\n\n"
      results << pre
      after = "\n"
    when "ol"
      unless self.nested_list?(states)
        results << self.newline(pre, nil)
        after = "\n"
      end
    when "ul"
      unless self.nested_list?(states)
        results << self.newline(pre, nil)
        after = "\n"
      end
    when "li"
      results << "\n"
      results << pre
    when "a"
      results << " ["
      after = ["](#{node.attributes["href"].value if node.attributes["href"]}) "]
      strip_content = true
    when "img"
      results << " !["
      results << node.attributes["alt"].value if node.attributes["alt"]
      results << "]("
      results << node.attributes["src"].value if node.attributes["src"]
      results << ") "
    when "text"
      results << node.text.strip.gsub("\n","").gsub(/ {2,}/," ")
    end
    node.children.each do |child|
      contents = self.parse_node(child, states)
      contents = contents.flatten.compact.join.strip if strip_content
      results << contents
    end
    results << after
    states.shift
    results
  end

  def self.nested_list?(states)
    result = false
    states.each_with_index do |state, index|
      next if index==0
      result = true if ["ul","ol","blockquote"].include?(state)
    end
    result
  end

  def self.newline(pre, line, count=1)
    result = []
    count.times do
      result << pre
      result << line
      result << "\n"
    end
    result
  end

  def self.prefix(states)
    result = []
    states.each_with_index do |state, index|
      if state == "blockquote"
        result.unshift(" > ")
      end          
      next if index==0
      if index==1
        if states.first == "li"
          if state == "ol"
            result.unshift(" 1. ")
          elsif state == "ul"
            result.unshift(" * ")
          end
        end
        next
      end
      case state
      when "ol"
        result.unshift("   ")
      when "ul"
        result.unshift("  ")
      end
    end
    result
  end
end
