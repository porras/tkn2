require 'curses'

module Tkn2
  class Screen
    def initialize
      Curses.init_screen
      Curses.cbreak
      Curses.nl
      Curses.noecho
      Curses.curs_set 0
      Curses.stdscr.keypad(true)
    end

    def render(deck)
      loop do
        break unless deck.current

        Curses.clear
        place_content deck.current.block

        case Curses.getch
        when 'q'
          break
        when 'n', Curses::Key::DOWN, Curses::Key::RIGHT, ' ', Curses::Key::ENTER, Curses::Key::NPAGE
          deck.next
        when 'p', Curses::Key::UP, Curses::Key::LEFT, Curses::Key::BACKSPACE, Curses::Key::PPAGE
          deck.prev
        when Curses::Key::HOME
          deck.first
        end
      end

      Curses.stdscr.close
    end

    private

    def place_content(content)
      raw_content = ContentBlock.new(ANSIReader::Remover.new.remove(content.content))
      top  = (Curses.lines - raw_content.height) / 2
      left = (Curses.cols  - raw_content.width) / 2
      window = Curses.stdscr.subwin(raw_content.height, raw_content.width, top, left)
      ANSIReader::Screen.new(window).parse(content.content)
      window.refresh
    end

  end
end
