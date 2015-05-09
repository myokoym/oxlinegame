require "oxlinegame/scene"
require "oxlinegame/object"
require "oxlinegame/player"

module Oxlinegame
  module Scene
    class Main
      include Base

      def initialize(window)
        super
        @n_rows = @window.options[:n_rows] || 3
        @cursor = Object::Cursor.new(@window, @n_rows)
        @objects << @cursor
        @board = Object::Board.new(@window, @n_rows)
        @objects << @board
        @players = [
          Player.new(Player::MAN, 1),
          Player.new(Player::COM, 2),
        ]
        @turn = 0
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
          succeeded = @board.mark(@players[@turn].mark,
                                  @cursor.x, @cursor.y)
          if succeeded
            @turn += 1
            @turn = 0 unless @players[@turn]
          end

          if @players[@turn].type == Player::COM and @board.markable?
            until @board.mark(@players[@turn].mark,
                              rand(@n_rows),
                              rand(@n_rows))
            end
            @turn += 1
            @turn = 0 unless @players[@turn]
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
