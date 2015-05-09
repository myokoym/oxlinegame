require "oooxxx/scene"
require "oooxxx/object"

module Oooxxx
  module Scene
    class Main
      include Base

      def initialize(window)
        super
        n_rows = @window.options[:n_rows] || 3
        @cursor = Object::Cursor.new(@window, n_rows)
        @objects << @cursor
        @board = Object::Board.new(@window, n_rows)
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
