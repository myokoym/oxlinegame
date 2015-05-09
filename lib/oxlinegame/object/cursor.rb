require "oooxxx/object/base"

module Oooxxx
  module Object
    class Cursor
      include Base

      def initialize(window, n_rows)
        super(window, window.width / 2, window.height / 2)
        @n_rows = n_rows
        @point = [1, 1]
        @width = @window.width / n_rows
        @height = @window.height / n_rows
        @color = Gosu::Color.argb(0x66ffffff)
      end

      def draw
        @window.draw_rectangle(@width * @point[0],
                               @height * @point[1],
                               @width * (@point[0] + 1),
                               @height * (@point[1] + 1),
                               @color,
                               ZOrder::OBJECT)
      end

      def x
        @point[0]
      end

      def y
        @point[1]
      end

      def up
        @point[1] -= 1
        @point[1] = 0 if @point[1] < 0
      end

      def down
        @point[1] += 1
        @point[1] = @n_rows - 1 if @point[1] > @n_rows - 1
      end

      def left
        @point[0] -= 1
        @point[0] = 0 if @point[0] < 0
      end

      def right
        @point[0] += 1
        @point[0] = @n_rows - 1 if @point[0] > @n_rows - 1
      end
    end
  end
end
