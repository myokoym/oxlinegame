require "oxlinegame/object/base"

module Oxlinegame
  module Object
    class Board
      include Base

      def initialize(window, n_rows)
        super(window, window.width / 2, window.height / 2)
        @cell_width = @window.width / n_rows
        @cell_height = @window.height / n_rows
        @cells = Array.new(n_rows) { Array.new(n_rows) { 0 } }
        @cell_images = [" ", "o", "x"].collect.with_index do |label, i|
          [
            i,
            Gosu::Image.from_text(@window, label, @font_path,
                                  @cell_height, 0, @cell_width, :center)
          ]
        end.to_h
      end

      def draw
        @cells.each_with_index do |columns, n_row|
          columns.each_with_index do |cell, n_column|
            @cell_images[cell].draw(@cell_width * n_column,
                                    @cell_height * n_row,
                                    ZOrder::OBJECT)

          end
        end
      end

      def mark(turn, x, y)
        if @cells[y][x] == 0
          @cells[y][x] = turn
          true
        else
          false
        end
      end

      def markable?
        @cells.any? do |columns|
          columns.any? {|cell| cell == 0 }
        end
      end
    end
  end
end
