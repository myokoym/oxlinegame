require "oxlinegame/scene"
require "oxlinegame/player"
require "oxlinegame/object"

module Oxlinegame
  module Scene
    class Title
      include Base

      def initialize(window)
        super
        @title = Gosu::Image.from_text(@window,
                                       @window.caption,
                                       @font_path,
                                       64,
                                       4,
                                       @window.width,
                                       :center)
        @guide = Gosu::Image.from_text(@window,
                                       "press enter",
                                       @font_path,
                                       36,
                                       4,
                                       @window.width,
                                       :center)
        @playerx_font = Gosu::Font.new(@window, @font_path, 18)
        @player_labels = ["MAN", "COM"].collect do |label|
          [
            Player.const_get(label),
            Gosu::Image.from_text(@window,
                                  label,
                                  @font_path,
                                  20,
                                  0,
                                  120,
                                  :center)
          ]
        end.to_h
        @players = Object::Box.new(@window,
                                   :horizontal,
                                   0, @window.height * 0.6,
                                   @window.width, @window.height * 0.2,
                                   @player_labels)
        @objects << @players
        @players << Player::MAN
        (@window.options[:n_players] - 1).times do
          @players << Player::COM
        end
        @players.cursor = 0
        @guide_color = Gosu::Color::WHITE
      end

      def update
        super
        if Time.now.sec % 2 == 0
          @guide_color = Gosu::Color::WHITE
        else
          @guide_color = Gosu::Color::GRAY
        end
      end

      def draw
        super
        @title.draw(0, @window.height * 0.2, ZOrder::TEXT)
        @guide.draw(0, @window.height * 0.8, ZOrder::TEXT,
                    1, 1, @guide_color)
        @players.each_with_index do |player, i|
          x = (@window.width / @players.size) * (i + 0.3)
          @playerx_font.draw("player#{i + 1}",
                             x, @window.height * 0.5,
                             ZOrder::TEXT)
        end
      end

      def button_down(id)
        case id
        when Gosu::KbUp
          @players[@players.cursor] = Player::MAN
        when Gosu::KbDown
          @players[@players.cursor] = Player::COM
        when Gosu::KbLeft
          @players.cursor -= 1
          if @players.cursor < 0
            if @players.size >= 2
              @players.pop
              @window.options[:n_players] -= 1
            end
            @players.cursor = 0
          end
        when Gosu::KbRight
          @players.cursor += 1
          if @players.cursor > @players.size - 1
            if @players.size <= 8
              @players << Player::COM
              @window.options[:n_players] += 1
            end
            @players.cursor = @players.size - 1
          end
        when Gosu::KbReturn
          @window.scenes.unshift(Main.new(@window, @players))
        end
      end
    end
  end
end
