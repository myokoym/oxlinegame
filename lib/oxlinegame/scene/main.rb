require "oxlinegame/scene"
require "oxlinegame/object"

module Oxlinegame
  module Scene
    class Main
      include Base

      MAN_TURN = 1
      COM_TURN = 2

      def initialize(window)
        super
        @n_rows = @window.options[:n_rows] || 3
        @cursor = Object::Cursor.new(@window, @n_rows)
        @objects << @cursor
        @board = Object::Board.new(@window, @n_rows)
        @objects << @board
        @turn = MAN_TURN
      end

      def update
        super
      end

      def draw
        super
      end

      def button_down(id)
        case id
        when Gosu::KbReturn
          succeeded = @board.mark(@turn, @cursor.x, @cursor.y)
          @turn = COM_TURN if succeeded

          if @turn == COM_TURN and @board.markable?
            until @board.mark(@turn,
                              rand(@n_rows),
                              rand(@n_rows))
            end
            @turn = MAN_TURN
          end
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
