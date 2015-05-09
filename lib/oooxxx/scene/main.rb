require "oooxxx/scene"

module Oooxxx
  module Scene
    class Main
      include Base

      def initialize(window)
        super
      end

      def update
        super
      end

      def draw
        super
      end

      def button_down(id)
        case id
        when Gosu::KbQ
          @window.scenes.shift
        end
      end
    end
  end
end
