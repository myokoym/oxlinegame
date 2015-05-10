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
        @items = []
        @cursor = nil
        @color = Gosu::Color::WHITE
        @cursor_color = Gosu::Color::RED
      end

      def draw
        @items.each_with_index do |item, i|
          case @direction
          when :vertical
            x1 = @x
            y1 = @y + @height / @items.size * i
            x2 = @x + @width / @items.size
            y2 = @y + @height / @items.size * (i + 1)
          when :horizontal
            x1 = @x + @width / @items.size * i
            y1 = @y
            x2 = @x + @width / @items.size * (i + 1)
            y2 = @y + @height / @items.size
          else
            raise "Supported directions are :vertical or :horizontal"
          end
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
    end
  end
end
