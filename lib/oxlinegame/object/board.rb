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
        @n_rows = n_rows
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

      def lined?
        @n_rows.times do |i|
          if line_check(@cells[i])
            return true
          end
          if line_check(@cells.collect {|columns| columns[i] })
            return true
          end
        end
        if line_check(@n_rows.times.collect {|i| @cells[i][i] })
          return true
        end
        if line_check(@n_rows.times.collect {|i| @cells[i][@n_rows - i - 1] })
          return true
        end
        false
      end

      private
      def line_check(line)
        line.uniq.size == 1 and line[0] != 0
      end
    end
  end
end
