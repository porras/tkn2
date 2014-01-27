require 'tkn2'

Tkn2.deck do
  options bg: :white, fg: :black

  center "wadus üníçöde"

  options fg: :red

  code <<-EOS
    require 'application_controller'
    require 'post'

    class PostsController < ApplicationController
      def index
        @posts = Post.all
      end
    end
  EOS

  options bg: :green

  section "This is a section", fg: :blue do
    center <<-EOS
      Hola
      Hola
    EOS
  end
end
