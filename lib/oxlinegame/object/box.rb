require "oxlinegame/object/base"

module Oxlinegame
  module Object
    class Box
      include Base

      attr_reader :items
      attr_accessor :color, :cursor, :cursor_color

      def initialize(window, direction, x, y, width, height, images={})
        directions = [:vertical, :horizontal]
        unless directions.include?(direction)
          raise "Supported directions are #{directions.join(", ")}: <#{directions}>"
        end
        super(window, x, y)
        @direction = direction
        @width = width
        @height = height
        @images = images
        @padding = 0.3
        @items = []
        @cursor = nil
        @color = Gosu::Color::WHITE
        @cursor_color = Gosu::Color::RED
        case @direction
        when :vertical
          @arrow1_x1 = x + width * 0.5
          @arrow1_x2 = x + width * 0.2
          @arrow1_x3 = x + width * 0.8
          @arrow1_y1 = y
          @arrow1_y2 = y + height * 0.1
          @arrow1_y3 = @arrow1_y2
          @arrow2_x1 = @arrow1_x1
          @arrow2_x2 = @arrow1_x2
          @arrow2_x3 = @arrow1_x3
          @arrow2_y1 = y + height
          @arrow2_y2 = y + height * 0.9
          @arrow2_y3 = @arrow2_y2
        when :horizontal
          @arrow1_x1 = x
          @arrow1_x2 = x + width * 0.05
          @arrow1_x3 = @arrow1_x2
          @arrow1_y1 = y + height * 0.5
          @arrow1_y2 = y + height * 0.2
          @arrow1_y3 = y + height * 0.8
          @arrow2_x1 = x + width
          @arrow2_x2 = x + width * 0.95
          @arrow2_x3 = @arrow2_x2
          @arrow2_y1 = @arrow1_y1
          @arrow2_y2 = @arrow1_y2
          @arrow2_y3 = @arrow1_y3
        end
        @arrow_color = Gosu::Color.argb(0x66ffffff)
      end

      def draw
        @items.each_with_index do |item, i|
          case @direction
          when :vertical
            width = @width
            height = @height / @items.size
            x1 = @x
            y1 = @y + height * i
            x2 = @x + width
            y2 = @y + height * (i + 1)
          when :horizontal
            width = @width / @items.size
            height = @height
            x1 = @x + width * i
            y1 = @y
            x2 = @x + width * (i + 1)
            y2 = @y + height
          else
            raise "Supported directions are :vertical or :horizontal"
          end
          x_padding = width * @padding
          y_padding = height * @padding
          x1 += x_padding
          y1 += y_padding
          x2 -= x_padding
          y2 -= y_padding
          if i == @cursor
            color = @cursor_color
          else
            color = @color
          end
          if item.is_a?(Gosu::Image)
            draw_image(item, x1, y1, x2, y2, color)
          else
            draw_image(@images[item], x1, y1, x2, y2, color)
          end
        end
        if @cursor
          draw_arrows
        end
      end

      def method_missing(name, *args, &block)
        if @items.respond_to?(name)
          @items.__send__(name, *args, &block)
        else
          super
        end
      end

      private
      def draw_image(item, x1, y1, x2, y2, color=Gosu::Color::WHITE)
        draw_as_rectangle(item, x1, y1, x2, y2,
                          color, ZOrder::OBJECT)
      end

      def draw_color(x1, y1, x2, y2, color)
        @window.draw_rectangle(x1, y1, x2, y2,
                               color, ZOrder::OBJECT)
      end

      def draw_as_rectangle(item, x1, y1, x2, y2, color, z_order)
        item.draw_as_quad(x1, y1, color,
                          x2, y1, color,
                          x2, y2, color,
                          x1, y2, color,
                          z_order)
      end

      def draw_arrows
        @window.draw_triangle(@arrow1_x1, @arrow1_y1, @arrow_color,
                              @arrow1_x2, @arrow1_y2, @arrow_color,
                              @arrow1_x3, @arrow1_y3, @arrow_color,
                              ZOrder::OBJECT)
        @window.draw_triangle(@arrow2_x1, @arrow2_y1, @arrow_color,
                              @arrow2_x2, @arrow2_y2, @arrow_color,
                              @arrow2_x3, @arrow2_y3, @arrow_color,
                              ZOrder::OBJECT)
      end
    end
  end
end
