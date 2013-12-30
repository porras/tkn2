module Tkn2
  module Utils
    class << self
      def strip_heredoc(string)
        indent = string.scan(/^[ \t]*(?=\S)/).min
        indent_level = (indent && indent.size) || 0
        string.gsub(/^[ \t]{#{indent_level}}/, '')
      end
    end
  end
end
