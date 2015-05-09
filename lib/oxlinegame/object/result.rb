module Oxlinegame
  module Object
    class Result
      include Base

      def initialize(window, text, font_path)
        super(window, window.width / 2, window.height / 2)
        @text = Gosu::Image.from_text(@window,
                                      text,
                                      font_path,
                                      @window.height / 6,
                                      @window.height / 10,
                                      @window.width,
                                      :center)
      end

      def draw
        @window.draw_rectangle(0, 0,
                               @window.width, @window.height,
                               Gosu::Color.argb(0xa0000000),
                               ZOrder::TEXT)
        @text.draw(0, @window.height * 0.3, ZOrder::TEXT)
      end
    end
  end
end
