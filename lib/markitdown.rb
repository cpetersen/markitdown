# encoding=utf-8 

require "markitdown/version"
require "nokogiri"

module Markitdown
  def self.from_html(html, language_classifier=nil)
    from_nokogiri(Nokogiri::XML(html).root, language_classifier)
  end

  def self.from_nokogiri(node, language_classifier=nil)
    # gsub(/\n\s+\n/,"\n\n") - remove lines with nothing but space characters
    # gsub(/\n{2,}/,"\n\n") - collapse any series of more an than 2 new lines down to 2
    # gsub(/\t+/," ") - collapse consecutive tabs down to a single space. I use tabs to pad divs and span, this causes multiple nested spans and divs to ultimately be surrounded by a single space.
    # gsub(/ ([\.\?])/,'\1') - removes a space before a period or question mark. Things like links get surrounded by spaces. If they appear at the end of a sentence, this makes sure the punctation isn't off.
    self.parse_node(node, [], language_classifier).flatten.compact.join.gsub(/\n\s+\n/,"\n\n").gsub(/\n{2,}/,"\n\n").gsub(/( > \n){2,}/,"\n > \n > ").gsub(/\t+/," ").gsub(/ ([\.\?])/,'\1').gsub(/\s*END_TAG\((.{1,3})\)/, "\\1").gsub(/\u00a0/, " ")
  end

  private
  def self.parse_node(node, states=[], language_classifier=nil)
    results=[]
    after = nil
    states.unshift node.name.downcase
    pre = prefix(states)
    recurse = true
    strip_content = false
    flatten_content = false
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
      after = "END_TAG(*) "
    when "i"
      results << " *"
      after = "END_TAG(*) "
    when "strong"
      results << " __"
      after = "END_TAG(__) "
    when "b"
      results << " __"
      after = "END_TAG(__) "
    when "u"
      results << " _"
      after = "END_TAG(_) "
    when "strike"
      results << " ~~"
      after = "END_TAG(~~) "
    when "del"
      results << " ~~"
      after = "END_TAG(~~) "
    when "mark"
      results << " =="
      after = "END_TAG(==) "
    when "sup"
      results << "^("
      after = "END_TAG(\)) "
    when "blockquote"
      results << "\n\n"
      results << pre
      after = "\n\n"
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
    when "dl"
      unless self.nested_list?(states)
        results << self.newline(pre, nil)
        after = "\n\n"
      end
    when "dt"
      results << "\n"
      results << pre
    when "dd"
      results << "\n"
      results << pre
      results << " : "
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
    when "code"
      if node.text.include?("\n")
        text = node.text.gsub(/^\n/,"").gsub(/\n\s*$/,"").gsub(/\u00a0/, " ")
        if language_classifier
          language = language_classifier.classify(text)
          results << "\n\n```#{language}\n#{text}\n```\n\n"
        else          
          results << "\n\n```\n#{text}\n```\n\n"
        end
      else
        results << " `#{node.text}` "
      end
      recurse = false
    when "table"
      results << "\n\n"
      after = "\n\n"
    when "th"
      results << "|"
      strip_content = true
      flatten_content = true
    when "td"
      results << "|"
      strip_content = true
      flatten_content = true
    when "tr"
      after = "|\n"
      table = find_parent(node.parent, "table")
      if table
        first_row = table.xpath(".//tr").first
        if first_row == node
          cell_count = node.xpath(".//th|td").count
          after << ("|---"*cell_count) + "|\n"
        end
      end
    end

    if recurse
      node.children.each do |child|
        contents = self.parse_node(child, states, language_classifier)
        contents = contents.flatten.compact.join.strip if strip_content
        contents = [contents].flatten.compact.join.gsub("\n", " ") if flatten_content
        results << contents
      end
    end
    
    if strip_content
      last_tags = results.pop
      after = after.flatten.compact.join if after.is_a?(Array)
      last_tags = "#{last_tags}#{after}"
      results << last_tags
    else
      results << after
    end
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

  def self.find_parent(node, tag_name)
    return nil unless node
    return node if node.name == tag_name
    find_parent(node.parent, tag_name)
  end
end
