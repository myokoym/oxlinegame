require "oxlinegame/scene"
require "oxlinegame/object"
require "oxlinegame/player"

module Oxlinegame
  module Scene
    class Main
      include Base

      def initialize(window, players=nil)
        players ||= [Player::MAN, Player::COM]
        super(window)
        @n_rows = @window.options[:n_rows] || 3
        @cursor = Object::Cursor.new(@window, @n_rows)
        @objects << @cursor
        @board = Object::Board.new(@window, @n_rows)
        @objects << @board
        @players = players.collect.with_index do |player, i|
          Player.new(player, i + 1)
        end
        @turn = 0
        @finished = false
      end

      def update
        return if @finished
        super
        if @players[@turn].type == Player::COM and @board.markable?
          loop do
            x = rand(@n_rows)
            y = rand(@n_rows)
            succeeded = @board.mark(@players[@turn].mark, x, y)
            if succeeded
              @cursor.x = x
              @cursor.y = y
              break
            end
          end
          turn_end
        end
      end

      def draw
        super
      end

      def button_down(id)
        case id
        when Gosu::KbReturn
          return unless @board.markable?
          return unless @players[@turn].type == Player::MAN

          succeeded = @board.mark(@players[@turn].mark,
                                  @cursor.x, @cursor.y)
          if succeeded
            turn_end
          end
        when Gosu::KbLeft
          @cursor.left
        when Gosu::KbRight
          @cursor.right
        when Gosu::KbUp
          @cursor.up
        when Gosu::KbDown
          @cursor.down
        when Gosu::KbQ
          @window.scenes.shift
        end
      end

      def turn_end
        if @board.lined?
          text = "Player#{@turn + 1}\nWin!"
          @objects << Object::Result.new(@window, text, @font_path)
          @finished = true
        elsif not @board.markable?
          text = "Draw\n:-)"
          @objects << Object::Result.new(@window, text, @font_path)
          @finished = true
        end
        @turn += 1
        @turn = 0 unless @players[@turn]
        false
      end
    end
  end
end
