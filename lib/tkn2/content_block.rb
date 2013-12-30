module Tkn2
  class ContentBlock
    attr_reader :content

    def initialize(content)
      @content = content
    end

    def height
      content.lines.size
    end

    def width
      content.lines.map(&:size).max
    end
  end
end
