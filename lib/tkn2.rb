require "tkn2/version"
require "tkn2/slide"
require "tkn2/deck"
require "tkn2/screen"
require "tkn2/ansi_reader"
require "tkn2/content_block"
require "tkn2/utils"

module Tkn2
  def self.deck(&block)
    Deck.new.tap do |deck|
      deck.instance_eval(&block)
    end.present!
  end
end
