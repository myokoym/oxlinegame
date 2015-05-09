require "oooxxx/scene"
require "oooxxx/object/board"

module Oooxxx
  module Scene
    class Main
      include Base

      def initialize(window)
        super
        @cell_width = @window.width / 3
        @cell_height = @window.height / 3
        @cursor = [1, 1]

        @board = Object::Board.new(@window, 3)
        @objects << @board
      end

      def update
        super
      end

      def draw
        super
        @window.draw_rectangle(@cell_width * @cursor[0],
                               @cell_height * @cursor[1],
                               @cell_width * (@cursor[0] + 1),
                               @cell_height * (@cursor[1] + 1),
                               Gosu::Color.argb(0x66ffffff),
                               ZOrder::OBJECT)
      end

      def button_down(id)
        case id
        when Gosu::KbLeft
          @cursor[0] -= 1
          @cursor[0] = 0 if @cursor[0] < 0
        when Gosu::KbRight
          @cursor[0] += 1
          @cursor[0] = 2 if @cursor[0] > 2
        when Gosu::KbUp
          @cursor[1] -= 1
          @cursor[1] = 0 if @cursor[1] < 0
        when Gosu::KbDown
          @cursor[1] += 1
          @cursor[1] = 2 if @cursor[1] > 2
        when Gosu::KbQ
          @window.scenes.shift
        end
      end
    end
  end
end
