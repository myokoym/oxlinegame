require "oooxxx/scene"
require "oooxxx/object"

module Oooxxx
  module Scene
    class Main
      include Base

      def initialize(window)
        super
        @cursor = Object::Cursor.new(@window, 3)
        @objects << @cursor
        @board = Object::Board.new(@window, 3)
        @objects << @board
      end

      def update
        super
      end

      def draw
        super
      end

      def button_down(id)
        case id
        when Gosu::KbLeft
          @cursor.left
        when Gosu::KbRight
          @cursor.right
        when Gosu::KbUp
          @cursor.up
        when Gosu::KbDown
          @cursor.down
        when Gosu::KbQ
          @window.scenes.shift
        end
      end
    end
  end
end
