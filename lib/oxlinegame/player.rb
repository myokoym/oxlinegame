module Oxlinegame
  class Player
    MAN = 0
    COM = 1

    attr_reader :type, :mark

    def initialize(type, mark)
      @type = type
      @mark = mark
    end
  end
end
