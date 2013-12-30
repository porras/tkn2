require 'tkn2'

Tkn2.deck do
  center "wadus üníçöde"

  code <<-EOS
    require 'application_controller'
    require 'post'

    class PostsController < ApplicationController
      def index
        @posts = Post.all
      end
    end
  EOS

  section "This is a section" do
    center <<-EOS
      Hola
      Hola
    EOS
  end
end
