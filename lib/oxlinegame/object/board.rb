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
        signs = [" ", "o", "x"]
        (@window.options[:n_players] - 2).times do |i|
          signs << i + 3
        end
        @cell_images = signs.collect.with_index do |label, i|
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
            @window.draw_rectangle_outline(@cell_width * n_column,
                                           @cell_height * n_row,
                                           @cell_width * (n_column + 1),
                                           @cell_height * (n_row + 1),
                                           Gosu::Color::GRAY,
                                           ZOrder::OBJECT)
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
        column_lines = @cells.transpose
        slant_lines = @cells.collect.with_index do |_line, i|
          line = _line.dup
          i.times do
            line.push(0)
          end
          (_line.size - 1 - i).times do
            line.unshift(0)
          end
          line
        end.transpose
        r_slant_lines = @cells.collect.with_index do |_line, i|
          line = _line.dup
          i.times do
            line.unshift(0)
          end
          (_line.size - 1 - i).times do
            line.push(0)
          end
          line
        end.transpose
        [
          @cells,
          column_lines,
          slant_lines,
          r_slant_lines,
        ].each do |lines|
          lines.each do |line|
            return true if line_check(line)
          end
        end
        false
      end

      private
      def line_check(line)
        n_win_cells = @window.options[:n_win_cells]
        if n_win_cells
          continuities = line.join.scan(/(\w)\1{#{n_win_cells - 1},}/)
          continuities.reject! {|continuity| continuity[0] == "0" }
          not continuities.empty?
        else
          line.uniq.size == 1 and line[0] != 0
        end
      end
    end
  end
end
