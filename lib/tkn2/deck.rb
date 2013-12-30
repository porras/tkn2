module Tkn2
  class Deck
    def initialize
      @slides = []
      @current = 0
      @renderer = Screen.new
    end

    def present!
      @renderer.render(self)
    end

    def current
      @slides[@current]
    end

    def next
      @current += 1 unless last?
    end

    def prev
      @current -= 1 unless first?
    end

    def first
      @current = 0
    end

    def first?
      @current == 0
    end

    def last?
      @current == @slides.size - 1
    end

    private

    def self.slide_method(name, klass)
      define_method name do |*args|
        add_slide klass.new(*args)
      end
    end

    def add_slide(slide)
      @slides << slide
    end

    slide_method :center,           Slide::Center
    slide_method :code,             Slide::Code
    slide_method :block,            Slide
    slide_method :section_header,   Slide::SectionHeader

    def section(title, &block)
      section_header title
      yield
    end
  end
end
