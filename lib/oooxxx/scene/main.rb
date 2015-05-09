require "oooxxx/scene"

module Oooxxx
  module Scene
    class Main
      include Base

      def initialize(window)
        super
        @cursor = [1, 1]
        @cells = [
          [0, 0, 0],
          [0, 1, 0],
          [2, 0, 0],
        ]
        @cell_width = @window.width / 3
        @cell_height = @window.height / 3
        @cell_images = [" ", "o", "x"].collect.with_index do |label, i|
          [
            i,
            Gosu::Image.from_text(@window, label, @font_path,
                                  @cell_height, 0, @cell_width, :center)
          ]
        end.to_h
      end

      def update
        super
      end

      def draw
        super
        @cells.each_with_index do |columns, n_row|
          columns.each_with_index do |cell, n_column|
            @cell_images[cell].draw(@cell_width * n_column,
                                    @cell_height * n_row,
                                    ZOrder::OBJECT)

          end
        end
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
