require 'coveralls'

class TestLanguageClassifier
  def classify(code)
    if code
      if code.match /<table>/
        return "html"
      elsif code.match /def/
        return "ruby"
      end
    end
  end
end

Coveralls.wear!
