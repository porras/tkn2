require 'ncurses'

module Tkn2
  class Screen
    def initialize
      Ncurses.initscr
      Ncurses.cbreak
      Ncurses.nl
      Ncurses.noecho
      Ncurses.curs_set 0
      Ncurses.stdscr.keypad(true)
    end

    def render(deck)
      loop do
        break unless deck.current

        Ncurses.clear
        place_content deck.current.block

        case Ncurses.getch
        when 'q'.ord, 27 # Escape
          break
        when 'n'.ord, Ncurses::KEY_DOWN, Ncurses::KEY_RIGHT, ' ', Ncurses::KEY_ENTER, Ncurses::KEY_NPAGE
          deck.next
        when 'p'.ord, Ncurses::KEY_UP, Ncurses::KEY_LEFT, Ncurses::KEY_BACKSPACE, Ncurses::KEY_PPAGE
          deck.prev
        when Ncurses::KEY_HOME
          deck.first
        end
      end
  
    ensure
      Ncurses.nocbreak
      Ncurses.echo
      Ncurses.endwin
    end

    private

    def place_content(content)
      raw_content = ContentBlock.new(ANSIReader::Remover.new.remove(content.content))
      top  = (Ncurses.getmaxy(Ncurses.stdscr) - raw_content.height) / 2
      left = (Ncurses.getmaxx(Ncurses.stdscr)  - raw_content.width) / 2
      window = Ncurses.stdscr.subwin(raw_content.height, raw_content.width, top, left)
      ANSIReader::Screen.new(window).parse(content.content)
      window.refresh
    end

  end
end
